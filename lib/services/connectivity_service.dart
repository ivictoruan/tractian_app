import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityService {
  Future<bool> hasInternetAccess();
}

class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity connectivity;

  ConnectivityServiceImpl({required this.connectivity});

  @override
  Future<bool> hasInternetAccess() async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com').timeout(
        const Duration(seconds: 6),
      );
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on TimeoutException {
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
