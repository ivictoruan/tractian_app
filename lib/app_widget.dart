import 'package:flutter/material.dart';

import 'presenter/screens/menu_screen/menu_screen.dart';
import 'presenter/screens/menu_screen/menu_screen_provider.dart';
import 'utils/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.theme,
        home: const MenuScreenProvider(
          child: MenuScreen(),
        ),
      );
}
