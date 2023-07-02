import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounding_storage/screens/form/form_sounding_notifier.dart';
import 'package:sounding_storage/screens/home/home_notifier.dart';
import 'package:sounding_storage/screens/list/list_quality_notifier.dart';
import 'package:sounding_storage/screens/list/list_sounding_notifier.dart';

import 'app.dart';
import 'base/interface/theme_notifier.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListQualityNotifier()),
        ChangeNotifierProvider(create: (_) => ListSoundingNotifier()),
        ChangeNotifierProvider(create: (_) => HomeNotifier()),
        ChangeNotifierProvider(create: (_) => FormSoundingNotifier()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: App(),
    ),
  );
}
