import 'package:flutter/material.dart';
import 'login_screen.dart'; // Giriş ekranını import edin
import 'register_screen.dart'; // Kayıt ekranını import edin

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage("assets/images/background.jpg"), // Arka plan resmi
            fit: BoxFit.cover, // Ekranın tamamını kaplasın
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/aclogo.png', // Logoyu ekliyoruz
              height: 300,
            ),
            const SizedBox(height: 30),
            // Giriş Yap Butonu
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'GİRİŞ YAP',
                style: TextStyle(
                  color: Color(0xFF0047AB), // Kobalt mavisi
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text(
              '-----VEYA-----',
              style: TextStyle(
                color: Color.fromARGB(106, 255, 255, 255), // Kobalt mavisi
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 0),
            // Kayıt Ol Butonu
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'KAYIT OL',
                style: TextStyle(
                  color: Color(0xFF0047AB), // Kobalt mavisi
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
