import 'package:flutter/material.dart';
import 'package:akillicuzdan/services/mongodb.dart';
import 'dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _register() async {
    await MongoDatabase.connect();
    await MongoDatabase.insertUser(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kayıt Ol", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 0, 60, 145),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildRegisterForm(),
    );
  }

  Widget _buildRegisterForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(controller: _usernameController, decoration: InputDecoration(labelText: 'Kullanıcı Adı')),
          TextField(controller: _emailController, decoration: InputDecoration(labelText: 'E-mail')),
          TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Şifre')),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _register, child: const Text('Kayıt Ol')),
        ],
      ),
    );
  }
}
