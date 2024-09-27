import 'package:flutter/material.dart';

import 'app_widget.dart';
import 'presenter/providers/app_provider.dart';

void main() {
  runApp(
    const AppProvider(
      child: AppWidget(),
    ),
  );
}
