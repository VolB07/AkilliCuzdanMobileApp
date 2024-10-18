//Avantajlı Krediler
import 'package:flutter/material.dart';

class AdvantageousCreditsPage extends StatefulWidget {
  @override
  _AdvantageousCreditsPageState createState() =>
      _AdvantageousCreditsPageState();
}

class _AdvantageousCreditsPageState extends State<AdvantageousCreditsPage> {
  String selectedCreditType = 'İhtiyaç'; // Default selected credit type

  final Map<String, IconData> creditTypes = {
    'İhtiyaç': Icons.account_balance_wallet,
    'Taşıt': Icons.directions_car,
    'Konut': Icons.home,
  };

  // Kredi teklifleri: Banka Adı, Faiz Oranı, Vade Süresi
  final Map<String, List<Map<String, String>>> loanOffers = {
    'İhtiyaç': [
      {
        'bank': 'Banka A',
        'kredimiktari': '50.000',
        'rate': '1.50%',
        'term': '36 Ay',
      },
      {
        'bank': 'Banka B',
        'kredimiktari': '50.000',
        'rate': '1.70%',
        'term': '24 Ay'
      },
      {
        'bank': 'Banka C',
        'kredimiktari': '50.000',
        'rate': '1.80%',
        'term': '12 Ay'
      },
    ],
    'Taşıt': [
      {
        'bank': 'Banka D',
        'kredimiktari': '50.000',
        'rate': '1.30%',
        'term': '48 Ay'
      },
      {
        'bank': 'Banka E',
        'kredimiktari': '50.000',
        'rate': '1.40%',
        'term': '36 Ay'
      },
    ],
    'Konut': [
      {
        'bank': 'Banka F',
        'kredimiktari': '50.000',
        'rate': '1.20%',
        'term': '120 Ay'
      },
      {
        'bank': 'Banka G',
        'kredimiktari': '50.000',
        'rate': '1.25%',
        'term': '180 Ay'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avantajlı Krediler',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 0, 60, 145), // cobalt blue background
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0xFF0047AB), // cobalt blue background for the page
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildCreditTypeCards(),
            const SizedBox(height: 20),
            Expanded(
              child: _buildLoanOffers(), // Kredi tekliflerini göster
            ),
          ],
        ),
      ),
    );
  }

  // Kredi türü kartlarını oluştur
  Widget _buildCreditTypeCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: creditTypes.keys.map((creditType) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCreditType = creditType; // Kategori seçimi
              });
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: selectedCreditType == creditType
                    ? Colors.white
                    : Colors.white.withOpacity(0.6), // white card
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    creditTypes[creditType],
                    size: 40,
                    color: const Color(0xFF0047AB), // cobalt blue icon
                  ),
                  const SizedBox(height: 10),
                  Text(
                    creditType,
                    style: TextStyle(
                      color: const Color(0xFF0047AB), // cobalt blue text
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Seçili kredi türüne göre kredi tekliflerini oluştur
  Widget _buildLoanOffers() {
    List<Map<String, String>> offers = loanOffers[selectedCreditType] ?? [];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: offers.length,
      itemBuilder: (context, index) {
        var offer = offers[index];

        return Card(
          color: Colors.white, // white card
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8), // Dikey aralık
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  offer['bank']!,
                  style: const TextStyle(
                    color: Color(0xFF0047AB), // cobalt blue text
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Faiz Oranı: ${offer['rate']}',
                  style: const TextStyle(
                    color: Color(0xFF0047AB), // cobalt blue text
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Vade Süresi: ${offer['term']}',
                  style: const TextStyle(
                    color: Color(0xFF0047AB), // cobalt blue text
                  ),
                ),
                Text(
                  'Kredi Miktarı: ${offer['kredimiktari']}',
                  style: const TextStyle(
                    color: Color(0xFF0047AB), // cobalt blue text
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}