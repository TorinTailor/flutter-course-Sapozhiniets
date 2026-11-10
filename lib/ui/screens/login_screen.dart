import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../data/auth_repository.dart';
import '../../utils/error_messages.dart';

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

  bool get _isRegisterButtonEnabled {
    if (isLogin) return true;
    return nameController.text.trim().isNotEmpty &&
        loginController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        nameError == null &&
        emailError == null &&
        passwordError == null;
  }

  @override
  void dispose() {
    nameController.dispose();
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
  final auth = context.read<AuthRepository>();
  try {
    await auth.signIn(
      email: loginController.text,
      password: passwordController.text,
    );
  } catch (e) {
    if (!mounted) return;
    setState(() => error = errorMessage(e));
  }
}

Future<void> _register() async {
  final auth = context.read<AuthRepository>();
  try {
    await auth.register(
      nickname: nameController.text,
      email: loginController.text,
      password: passwordController.text,
    );
  } catch (e) {
    if (!mounted) return;
    setState(() => error = errorMessage(e));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 50),
            Align(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFFFFB1B1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: const Color(0xFFFC6860)),
                ),
                child: Icon(Icons.gamepad_outlined, size: 50),
              ),
            ),

            SizedBox(height: 20),

            Align(
              child: Container(
                width: 326,
                alignment: Alignment.centerLeft,
                child: Text(
                  isLogin ? 'Вход' : 'Регистрация',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
                ),
              ),
            ),

            SizedBox(height: 10),

            Align(
              child: Container(
                width: 326,
                alignment: Alignment.centerLeft,
                child: Text(
                  isLogin
                      ? 'Войдите, чтобы видеть библиотеку и своё избранное'
                      : 'Создайте аккаунт — избранное будет сохраняться за вами',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

            if (error != null)
              Align(
                child: Container(
                  width: 326,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    border: Border.all(
                      color: const Color(0xFFE57373),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xFFD32F2F),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          error!,
                          style: const TextStyle(
                            color: Color(0xFFD32F2F),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (!isLogin)
              Align(
                child: Container(
                  width: 326,
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text('Ваш никнейм'),
                ),
              ),

            if (!isLogin)
              Align(
                child: SizedBox(
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
                        if (value.trim().isEmpty) {
                          nameError = 'Введите имя';
                        } else if (value.trim().length < 3) {
                          nameError =
                              'Никнейм должен быть не короче 3 символов';
                        } else {
                          nameError = null;
                        }
                      });
                    },
                  ),
                ),
              ),

            Align(
              child: Container(
                width: 326,
                margin: EdgeInsets.only(bottom: 10, top: 10),
                alignment: Alignment.centerLeft,
                child: Text('Почта'),
              ),
            ),

            Align(
              child: SizedBox(
                width: 326,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'you@example.com',
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
                        emailError = 'Введите корректный Email';
                      } else {
                        emailError = null;
                      }
                    });
                  },
                ),
              ),
            ),

            Align(
              child: Container(
                width: 326,
                margin: EdgeInsets.only(bottom: 10, top: 10),
                alignment: Alignment.centerLeft,
                child: Text('Пароль'),
              ),
            ),

            Align(
              child: SizedBox(
                width: 326,
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
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty && value.length < 8) {
                        passwordError = 'Не менее 8-ми символов';
                      } else if (value.isEmpty) {
                        passwordError = 'Это поле обязательно';
                      } else {
                        passwordError = null;
                      }
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 20),

            if (isLogin)
              Align(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFB1B1),
                    minimumSize: Size(332, 60),
                    foregroundColor: Color(0xFF5A0000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),

                  onPressed: _signIn,

                  child: Text(
                    'Войти',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            if (!isLogin)
              Align(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFB1B1),
                    minimumSize: Size(332, 60),
                    foregroundColor: Color(0xFF5A0000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),
                  onPressed: _isRegisterButtonEnabled ? _register : null,
                  child: Text(
                    'Зарегистрироваться',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            SizedBox(height: 10),

            Align(
              child: TextButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
