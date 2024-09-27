import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../services/api_service.dart';
import '../../../services/connectivity_service.dart';
import 'menu_screen_state.dart';

class MenuScreenProvider extends StatelessWidget {
  const MenuScreenProvider({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuScreenState(
              apiService: context.read<ApiService>(),
              connectivityService: context.read<ConnectivityService>(),
            ),
          ),
        ],
        child: child,
      );
}
