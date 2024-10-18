//yatırım takibi sayfası
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InvestmentTrackingPage extends StatefulWidget {
  const InvestmentTrackingPage({super.key});

  @override
  _InvestmentTrackingPageState createState() => _InvestmentTrackingPageState();
}

class _InvestmentTrackingPageState extends State<InvestmentTrackingPage> {
  List<String> watchlist = [];
  String selectedCategory = 'Döviz';
  String? selectedUnit;

  // Yatırım bilgileri
  Map<String, double> investmentData = {};
  Map<String, double> previousInvestmentData = {}; // Önceki fiyatlar
  Map<String, double> changePercentData = {}; // Yüzdelik değişimler

  Map<String, List<String>> investmentUnits = {
    'Döviz': ['USD', 'EUR', 'GBP'],
    'Altın-Gümüş': ['Altın', 'Gümüş'],
    'Hisse Senedi': ['AAPL', 'GOOGL', 'TSLA'],
    'Kripto Paralar': ['BTC', 'ETH', 'LTC'],
  };

  @override
  void initState() {
    super.initState();
    fetchData(); // Sayfa yüklendiğinde veriyi çek
  }

  // API'den verileri çekme fonksiyonu
  Future<void> fetchData() async {
    const String apiKey =
        '6Spypcli1usIfBagvY3FE6_eLHJCKb7J'; // Polygon.io API anahtarı

    List<String> currencies = ['USD', 'EUR', 'GBP'];
    List<String> cryptoCurrencies = ['BTC', 'ETH', 'LTC'];
    List<String> stocks = ['AAPL', 'GOOGL', 'TSLA'];

    try {
      // Döviz fiyatlarını çekme
      for (String currency in currencies) {
        final response = await http.get(Uri.parse(
            'https://api.polygon.io/v1/conversion/$currency/TRY?apiKey=$apiKey'));

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          double exchangeRate = data['result']['value']; // Döviz fiyatı

          setState(() {
            previousInvestmentData['$currency/TRY'] =
                investmentData['$currency/TRY'] ?? 0.0;
            investmentData['$currency/TRY'] = exchangeRate;
            changePercentData['$currency/TRY'] = calculateChangePercent(
                previousInvestmentData['$currency/TRY'], exchangeRate);
          });
        } else {
          print('Döviz verisi alınamadı: ${response.statusCode}');
        }
      }

      // Kripto para fiyatlarını çekme
      for (String crypto in cryptoCurrencies) {
        final response = await http.get(Uri.parse(
            'https://api.polygon.io/v2/aggs/ticker/X:$crypto/prev?apiKey=$apiKey'));

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data['results'] != null && data['results'].isNotEmpty) {
            double cryptoRate = data['results'][0]['c']; // Kripto fiyatı

            setState(() {
              previousInvestmentData['$crypto/USD'] =
                  investmentData['$crypto/USD'] ?? 0.0;
              investmentData['$crypto/USD'] = cryptoRate;
              changePercentData['$crypto/USD'] = calculateChangePercent(
                  previousInvestmentData['$crypto/USD'], cryptoRate);
            });
          } else {
            print('Kripto verisi bulunamadı');
          }
        } else {
          print('Kripto verisi alınamadı: ${response.statusCode}');
        }
      }

      // Hisse senedi fiyatlarını çekme
      for (String stock in stocks) {
        final response = await http.get(Uri.parse(
            'https://api.polygon.io/v2/aggs/ticker/$stock/prev?apiKey=$apiKey'));

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data['results'] != null && data['results'].isNotEmpty) {
            double stockPrice = data['results'][0]['c']; // Hisse fiyatı

            setState(() {
              previousInvestmentData[stock] = investmentData[stock] ?? 0.0;
              investmentData[stock] = stockPrice;
              changePercentData[stock] = calculateChangePercent(
                  previousInvestmentData[stock], stockPrice);
            });
          } else {
            print('Hisse verisi bulunamadı');
          }
        } else {
          print('Hisse senedi verisi alınamadı: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Veri çekme hatası: $e');
    }
  }

  double calculateChangePercent(double? previousPrice, double currentPrice) {
    if (previousPrice == null || previousPrice == 0.0) {
      return 0.0;
    }
    return ((currentPrice - previousPrice) / previousPrice) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yatırım Takibi',
          style: TextStyle(color: Colors.white), // Beyaz başlık
        ),
        backgroundColor: const Color.fromARGB(255, 0, 60, 145), // Kobalt mavisi arkaplan
        iconTheme: const IconThemeData(color: Colors.white), // Beyaz ok ikonu
      ),
      body: Container(
        color: const Color(0xFF0047AB), // Arkaplan kobalt mavisi
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildInvestmentDropdown(),
                    _buildInvestmentUnits(),
                    _buildWatchlistCard(),
                  ],
                ),
              ),
            ),
            Container(
              color: const Color(
                  0xFF0047AB), // Watchlist altındaki beyaz alanı kapatmak için
              height: 50.0, // Yükseklik isteğe göre ayarlanabilir
            ),
          ],
        ),
      ),
    );
  }

  // Yatırım birimi seçme dropdown menüsü
  Widget _buildInvestmentDropdown() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0047AB), // Kobalt mavisi arkaplan
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: DropdownButton<String>(
          value: selectedCategory,
          dropdownColor: const Color(
              0xFF0047AB), // Dropdown menüsü arkaplanı kobalt mavisi
          iconEnabledColor: Colors.white, // Ok ikonu beyaz
          underline: Container(), // Alt çizgiyi kaldır
          style: const TextStyle(
              color: Colors.white), // Dropdown menüsü yazı rengi beyaz
          onChanged: (String? newValue) {
            setState(() {
              selectedCategory = newValue!;
              selectedUnit =
                  null; // Kategori değiştiğinde, birim seçimini sıfırla
            });
          },
          items: investmentUnits.keys
              .map<DropdownMenuItem<String>>((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category,
                  style:
                      const TextStyle(color: Colors.white)), // Yazı rengi beyaz
            );
          }).toList(),
        ),
      ),
    );
  }

  // Seçilen kategoriye ait yatırım birimlerinin listesini gösteren kartlar
  Widget _buildInvestmentUnits() {
    if (investmentUnits[selectedCategory] == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: investmentUnits[selectedCategory]!
          .map((unit) => Card(
                color: Colors.white, // Kart rengi beyaz
                child: ListTile(
                  title: Text(unit,
                      style: const TextStyle(
                          color: Color(
                              0xFF0047AB))), // Kart içindeki yazı kobalt mavisi
                  onTap: () {
                    setState(() {
                      selectedUnit = unit;
                      if (!watchlist.contains(unit)) {
                        watchlist.add(unit);
                      }
                    });
                  },
                ),
              ))
          .toList(),
    );
  }

  // Watchlist kartı: seçilen yatırımlar ve yüzdelik değişimleri
  Widget _buildWatchlistCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Watchlist',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white), // Beyaz başlık
          ),
          ...watchlist.map((unit) => Card(
                color: Colors.white, // Kart rengi beyaz
                child: ListTile(
                  title: Text(unit,
                      style: const TextStyle(
                          color: Color(
                              0xFF0047AB))), // Kart içindeki yazı kobalt mavisi
                  subtitle: Text(
                    'Fiyat: ${investmentData[unit]?.toStringAsFixed(2) ?? 'Bilinmiyor'}\nDeğişim: ${changePercentData[unit]?.toStringAsFixed(2) ?? '0.00'}%',
                    style: TextStyle(
                      color: changePercentData[unit] != null &&
                              changePercentData[unit]! >= 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete,
                        color: Colors.red), // Çöp kutusu ikonu
                    onPressed: () {
                      setState(() {
                        watchlist.remove(unit); // Birimi watchlist'ten kaldır
                      });
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }
}