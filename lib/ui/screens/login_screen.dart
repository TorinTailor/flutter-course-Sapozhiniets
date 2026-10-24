import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/screens/catalog_screen.dart';

//TODO 2: Сделать полосу прокрутки

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  String? error;
  String? nameError;
  String? emailError;
  String? passwordError;
  bool isLogin = true;
  bool _obscureText = true;

  @override
  void dispose() {
    nameController.dispose();
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 70),

            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFFFB1B1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2, color: const Color(0xFFFC6860)),
              ),
              child: Icon(Icons.gamepad_outlined, size: 50),
            ),

            SizedBox(height: 20),

            Container(
              width: 326,
              alignment: Alignment.centerLeft,
              child: Text(
                isLogin ? 'Вход' : 'Регистрация',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
              ),
            ),

            SizedBox(height: 10),

            Container(
              width: 326,
              alignment: Alignment.centerLeft,
              child: Text(
                isLogin
                    ? 'Войдите, чтобы видеть библиотеку и своё избранное'
                    : 'Создайте аккаунт — избранное будет сохраняться за вами',
                style: TextStyle(fontSize: 20),
              ),
            ),

            if (error != null) Text(error!),

            Container(
              width: 326,
              margin: EdgeInsets.only(bottom: 10, top: 10),
              alignment: Alignment.centerLeft,
              child: Text('Ваш никнейм'),
            ),

            SizedBox(
              width: 326,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'You0000',
                  errorText: nameError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFFF6C4C1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFFF6C4C1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: nameController,
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      nameError = 'Введите имя';
                    } else {
                      nameError = null;
                    }
                  });
                },
              ),
            ),

            Container(
              width: 326,
              margin: EdgeInsets.only(bottom: 10, top: 10),
              alignment: Alignment.centerLeft,
              child: Text('Почта'),
            ),

            SizedBox(
              width: 326,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'you@exampie.com',
                  errorText: emailError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFFF6C4C1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFFF6C4C1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: loginController,
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      emailError = 'Это обязательное поле';
                    } else if (value.isNotEmpty && !value.contains('@')) {
                      emailError = 'Введите коректный Email';
                    } else {
                      emailError = null;
                    }
                  });
                },
              ),
            ),

            Container(
              width: 320,
              margin: EdgeInsets.only(bottom: 10, top: 10),
              alignment: Alignment.centerLeft,
              child: Text('Пароль'),
            ),

            Container(
              width: 326,
              margin: EdgeInsetsGeometry.only(left: 32, right: 32),
              child: TextField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  errorText: passwordError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFFF6C4C1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFFF6C4C1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText; // переключаем состояние
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty && value.length < 8) {
                      passwordError = 'Не менее 8-ми символов';
                    } 
                    
                    else if (value.isEmpty) {
                      passwordError = 'Это поле обязательно';
                    } 

                    else {
                      passwordError = null;
                    }
                  });
                },
              ),
            ),

            SizedBox(height: 20),

            if (isLogin)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFB1B1),
                  minimumSize: Size(332, 60),
                  foregroundColor: Color(0xFF5A0000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),

                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: loginController.text,
                      password: passwordController.text,
                    );
                    if (!mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CatalogScreen()),
                    );
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      error = 'Ошибка: $e';
                    });
                  }
                },

                child: Text(
                  'Войти',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

            if (!isLogin)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFB1B1),
                  minimumSize: Size(332, 60),
                  foregroundColor: Color(0xFF5A0000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: loginController.text,
                      password: passwordController.text,
                    );
                    if (!mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CatalogScreen()),
                    );
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      error = 'Ошибка: $e';
                    });
                  }
                },
                child: Text(
                  'Зарегистрироваться',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

            SizedBox(height: 10),

            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                isLogin
                    ? 'Нет аккаунта? Зарегестрироваться'
                    : 'Уже есть аккаунт? Войти',
              ),
            ),

            SizedBox(height: 10),

            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signInAnonymously();
                if (!mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogScreen()),
                );
              },
              child: Text('Анонимный пользователь'),
            ),
          ],
        ),
      ),
    );
  }
}
