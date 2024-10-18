// Dashboard sayfası
import 'package:flutter/material.dart';
import 'budgetplan_screen.dart';
import 'invesmenttracking_screen.dart';
import 'discountedproducts_screen.dart';
import 'advantageouscredits_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Akıllı Cüzdanım",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 0, 60, 145),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF0047AB),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                children: [
                  _buildCard(context, 'Bütçe Planla', Icons.attach_money),
                  _buildCard(context, 'İndirimli Ürünler', Icons.local_offer),
                  _buildCard(context, 'Yatırım Takibi', Icons.trending_up),
                  _buildCard(context, 'Avantajlı Krediler', Icons.credit_card),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Kart yapısı
  Widget _buildCard(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (title == 'Bütçe Planla') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BudgetPlanScreen()),
          );
        } else if (title == 'Yatırım Takibi') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const InvestmentTrackingPage()),
          );
         } else if (title == 'İndirimli Ürünler') {
           Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => const DiscountedProductsPage()),
           );
        } else if (title == 'Avantajlı Krediler') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdvantageousCreditsPage()),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: const Color(0xFF0047AB)),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF0047AB),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


