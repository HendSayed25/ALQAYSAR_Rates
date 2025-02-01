import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';

import '../../../main.dart';

enum Languages { AR, EN }

Languages appLanguage = Languages.EN;

class AppLanguages {
  static const List<Locale> locals = [Locale('en'), Locale('ar')];
  static const Locale startLocal = Locale('en');
  static const Locale fallBackLocal = Locale('en');
  static String translationsPath = 'assets/translations';

  static void init(BuildContext context) {
    appLanguage = getCurrentLang(context);
  }

  static void toggleLocal(BuildContext context) async {
    Locale currentLocale = context.locale;
    Locale newLocale = currentLocale == locals.first ? locals.last : locals.first;

    appLanguage = newLocale.languageCode == 'ar' ? Languages.AR : Languages.EN;

    context.setLocale(newLocale);

    // Reassemble to apply changes
    await engine.performReassemble();
  }

  static String getCurrentLocal(BuildContext context) {
    return context.locale.languageCode;
  }

  static Languages getCurrentLang(BuildContext context) {
    switch (getCurrentLocal(context)) {
      case 'en':
        return Languages.EN;
      case 'ar':
        return Languages.AR;
      default:
        return Languages.EN;
    }
  }


  static TextDirection? getCurrentTextDirection(BuildContext context) {
    switch (context.locale.languageCode) {
      case 'en':
        return TextDirection.ltr;
      case 'ar':
        return TextDirection.rtl;
      default:
        return TextDirection.ltr;
    }
  }
}
