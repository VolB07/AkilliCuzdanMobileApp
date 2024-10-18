import 'package:flutter/material.dart';
import 'package:akillicuzdan/services/mongodb.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    await MongoDatabase.connect();
    var user = await MongoDatabase.getUser(
      _emailController.text,
      _passwordController.text,
    );
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else {
      // Hatalı giriş mesajı
      showDialog(
        context: context,
        builder: (context) => AlertDialog(content: const Text('Kullanıcı adı veya şifre hatalı')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giriş Yap", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 0, 60, 145),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildLoginForm(),
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(controller: _emailController, decoration: InputDecoration(labelText: 'E-mail')),
          TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Şifre')),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _login, child: const Text('Giriş Yap')),
        ],
      ),
    );
  }
}
