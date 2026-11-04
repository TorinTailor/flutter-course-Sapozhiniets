import 'package:connectivity_plus/connectivity_plus.dart';

/// Есть ли сейчас подключение к сети (Wi-Fi, мобильный интернет и т.п.).
///
/// Если саму проверку выполнить не удалось, считаем, что сеть есть:
/// лучше дать действию шанс, чем заблокировать приложение по ошибке.
Future<bool> hasInternet() async {
  try {
    final results = await Connectivity().checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  } catch (_) {
    return true;
  }
}
