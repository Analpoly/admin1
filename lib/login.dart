import 'package:admin1/homepage.dart';
import 'package:admin1/logo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Adminlogin extends StatefulWidget {
  const Adminlogin({super.key});

  @override
  State<Adminlogin> createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String _correctUsername = 'admin';
  final String _correctPassword = 'admin123';

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username == _correctUsername && password == _correctPassword) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('adminUsername', username);
      await pref.setString('adminPassword', password);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Homepage()), // Replace with your next page
      ).then((_) {
        _usernameController.clear();
        _passwordController.clear();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Incorrect username or password'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Login')),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  CustomPaint(
                    size: Size(100, 100),
                    painter: CirclePainter(),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                      height: 200,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(23))),
                                labelText: 'Username'),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(23))),
                                labelText: 'Password'),
                            obscureText: true,
                          ),
                        ]),
                      )),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
