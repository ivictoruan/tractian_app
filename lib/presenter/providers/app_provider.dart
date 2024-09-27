import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../../services/api_service.dart';
import '../../services/connectivity_service.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(create: (_) => Dio()),
          Provider<ApiService>(
            create: (context) => DioApiServiceImpl(
              dio: context.read<Dio>(),
            ),
          ),
          Provider(create: (_) => Connectivity()),
          Provider<ConnectivityService>(
            create: (context) => ConnectivityServiceImpl(
              connectivity: context.read<Connectivity>(),
            ),
          ),
        ],
        child: child,
      );
}
