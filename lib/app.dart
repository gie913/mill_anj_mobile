

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounding_storage/base/interface/theme_notifier.dart';
import 'package:sounding_storage/screens/splash/splash_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) => MaterialApp(
        theme: theme.getTheme(),
        darkTheme: theme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}