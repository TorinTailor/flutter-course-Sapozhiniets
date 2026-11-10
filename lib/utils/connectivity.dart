import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasInternet() async {
  try {
    final results = await Connectivity().checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  } catch (_) {
    return true;
  }
}
