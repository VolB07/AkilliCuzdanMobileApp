import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiscountedProductsPage extends StatefulWidget {
  const DiscountedProductsPage({super.key});

  @override
  _DiscountedProductsPageState createState() => _DiscountedProductsPageState();
}

class _DiscountedProductsPageState extends State<DiscountedProductsPage> {
  List<Map<String, dynamic>> _stores = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        _fetchNearbyStores(position.latitude, position.longitude);
      } catch (e) {
        print("Konum alınamadı: $e");
      }
    } else if (status.isDenied) {
      print("Kullanıcı konum iznini reddetti");
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _fetchNearbyStores(double latitude, double longitude) async {
    final String apiKey =
        'AIzaSyBKMSM5hocxFPwGdF4z4GI60xn-lunlI38'; // API Keyinizi buraya ekleyin
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=5000&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        // Belirli zincir mağaza isimleri
final List<String> chainStores = [
  'carrefour',
  'migros',
  'a101',
  'bim',
  'lc waikiki',
  'koton',
  'teknosa',
  'gratis',
  'watsons',
  'koçtaş',
  'şok market',
  'carrefoursa', // Örneğin, farklı bir isim
];

// Kontrol işlemi
_stores = data['results']
    .where((store) => chainStores.any((name) => store["name"].toLowerCase() == name))
    .map<Map<String, dynamic>>((store) => {
          "name": store["name"],
          "address": store["vicinity"],
          "lat": store["geometry"]["location"]["lat"],
          "long": store["geometry"]["location"]["lng"],
        })
    .toList();

      });
    } else {
      print("Mağazalar alınamadı: ${response.reasonPhrase}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'İndirimli Ürünler',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 60, 145),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0xFF0047AB),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Kategorilere Göre İndirimler",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryCard(context, 'Gıda Ürünleri', Icons.fastfood),
                  _buildCategoryCard(context, 'Ev/Yaşam', Icons.home),
                  _buildCategoryCard(context, 'Kozmetik/Hijyen', Icons.brush),
                  _buildCategoryCard(
                      context, 'Anne Çocuk Ürünleri', Icons.child_care),
                  _buildCategoryCard(context, 'Hediyeler', Icons.card_giftcard),
                  _buildCategoryCard(
                      context, 'Evcil Hayvan Malzemeleri', Icons.pets),
                  _buildCategoryCard(
                      context, 'Giyim/Ayakkabı', Icons.shopping_bag),
                  _buildCategoryCard(
                      context, 'Spor/Eğlence', Icons.sports_soccer),
                  _buildCategoryCard(context, 'Kırtasiye', Icons.edit),
                  _buildCategoryCard(context, 'Elektronik', Icons.phone_iphone),
                  _buildCategoryCard(context, 'Hazır Gıda', Icons.lunch_dining),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Mağazalar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _stores.length,
                itemBuilder: (context, index) {
                  return _buildStoreCard(context, _stores[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreCard(BuildContext context, Map<String, dynamic> store) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      elevation: 4,
      child: ExpansionTile(
        title: Text(
          store["name"],
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0047AB),
          ),
        ),
        children: [
          ListTile(
            title: Text(
              store["address"] ?? "Adres bulunamadı.",
              style: const TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            title: Text(
              'Koordinatlar: ${store['lat']}, ${store['long']}',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 120,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: const Color(0xFF0047AB)),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0047AB),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
