import 'package:flutter/material.dart';
import 'package:garage_app/styles/my_theme.dart';
import 'package:garage_app/l10n/l10n.dart';
import 'package:garage_app/widget/garage_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<ScaffoldMessengerState> globalScaffoldMessenger =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: globalScaffoldMessenger,
      theme: myThemeData,
      supportedLocales: L10n.languages,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Scaffold(
        body: GarageRoute(),
      ),
    );
  }
}
