import 'package:flutter/material.dart';
import 'package:garage_app/styles/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaterialWidgetWrapper extends StatelessWidget {
  final Widget child;
  final Locale selectedLocale;

  MaterialWidgetWrapper(
      {Key? key, required this.child, this.selectedLocale = const Locale('en')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myThemeData,
      locale: selectedLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }
}
