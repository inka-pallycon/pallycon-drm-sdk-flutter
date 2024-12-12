import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  static Future<bool> get isConnected async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    for (var result in connectivityResult) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        return Future.value(true);
      }
    }

    return Future.value(false);
  }
}
