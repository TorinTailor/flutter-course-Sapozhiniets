import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 70),
            //Padding(padding: EdgeInsetsGeometry.only(top: 70, left: 30, right: 30)),
            Container(
              padding: EdgeInsetsGeometry.only(left: 30, right: 30),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'you@exampie.com',
                  //errorText: 'Это обязательное поле',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
                controller: loginController,
              ),
            ),

            SizedBox(height: 10),
            TextField(controller: passwordController, obscureText: true),
            if (error != null) Text(error!),
            /*
            ElevatedButton(
              onPressed: () async {
                try {
                  final cred = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                        email: loginController.text,
                        password: passwordController.text,
                      );
                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                } on FirebaseAuthException catch (e) {
                  setState(() {
                    error = 'Ошибка: $e';
                  });
                }
              },
              child: Text('Войти'),
            ),
            
            ElevatedButton(
              onPressed: () async {
                try {
                  final cred = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                        email: loginController.text,
                        password: passwordController.text,
                      );
                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                } on FirebaseAuthException catch (e) {
                  setState(() {
                    error = 'Ошибка: $e';
                  });
                }
              },
              child: Text('Зарегистрироваться'),
            ),
            */
          ],
        ),
      ),
    );
  }
}
