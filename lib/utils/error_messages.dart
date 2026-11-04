import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

const noInternetMessage = 'Нет соединения с интернетом';

const noInternetActionMessage =
    'Нет подключения к интернету. Проверьте соединение и повторите попытку';

String errorMessage(Object error) {
  if (error is FirebaseAuthException) return _authMessage(error.code);
  if (error is FirebaseException) return _firebaseMessage(error.code);
  if (error is TimeoutException) {
    return 'Сервер долго не отвечает. Попробуйте ещё раз';
  }
  return 'Что-то пошло не так. Попробуйте ещё раз';
}

String _authMessage(String code) => switch (code) {
  'invalid-email' => 'Некорректный адрес почты',
  'user-not-found' => 'Аккаунт с такой почтой не найден',
  'wrong-password' => 'Неверный пароль',
  'invalid-credential' ||
  'invalid-login-credentials' => 'Неверная почта или пароль',
  'user-disabled' => 'Этот аккаунт отключён',
  'email-already-in-use' => 'Эта почта уже зарегистрирована. Попробуйте войти',
  'weak-password' => 'Слишком простой пароль. Придумайте подлиннее',
  'operation-not-allowed' => 'Этот способ входа отключён в настройках проекта',
  'too-many-requests' => 'Слишком много попыток. Подождите и попробуйте снова',
  'network-request-failed' => noInternetMessage,
  _ => 'Не удалось выполнить вход. Попробуйте ещё раз',
};

String _firebaseMessage(String code) => switch (code) {
  'permission-denied' => 'Нет доступа к данным',
  'unauthenticated' => 'Нужно войти в аккаунт',
  'unavailable' => 'Нет соединения с сервером. Проверьте интернет',
  'deadline-exceeded' => 'Сервер долго не отвечает. Попробуйте ещё раз',
  'not-found' => 'Данные не найдены',
  _ => 'Что-то пошло не так. Попробуйте ещё раз',
};
