import 'package:cupertino_ui/cupertino_ui.dart' as modern_cupertino;
import 'package:flutter/cupertino.dart' as flutter_cupertino;
import 'package:flutter/material.dart' as flutter_material;
import 'package:flutter/widgets.dart' as flutter_widgets;
import 'package:flutter_localizations/flutter_localizations.dart' as flutter_l10n;
import 'package:material_ui/material_ui.dart' as modern_material;

/// Fallback for `package:material_ui`'s [MaterialLocalizations]
class ModernFallbackMaterialLocalizationsDelegate
    extends flutter_widgets.LocalizationsDelegate<modern_material.MaterialLocalizations> {
  const ModernFallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(flutter_widgets.Locale locale) => true;

  @override
  Future<modern_material.MaterialLocalizations> load(flutter_widgets.Locale locale) {
    if (modern_material.GlobalMaterialLocalizations.delegate.isSupported(locale)) {
      return modern_material.GlobalMaterialLocalizations.delegate.load(locale);
    }
    return modern_material.GlobalMaterialLocalizations.delegate.load(const flutter_widgets.Locale('ru'));
  }

  @override
  bool shouldReload(ModernFallbackMaterialLocalizationsDelegate old) => false;
}

/// Fallback for `package:cupertino_ui`'s [CupertinoLocalizations]
class ModernFallbackCupertinoLocalizationsDelegate
    extends flutter_widgets.LocalizationsDelegate<modern_cupertino.CupertinoLocalizations> {
  const ModernFallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(flutter_widgets.Locale locale) => true;

  @override
  Future<modern_cupertino.CupertinoLocalizations> load(flutter_widgets.Locale locale) {
    if (modern_cupertino.GlobalCupertinoLocalizations.delegate.isSupported(locale)) {
      return modern_cupertino.GlobalCupertinoLocalizations.delegate.load(locale);
    }
    return modern_cupertino.GlobalCupertinoLocalizations.delegate.load(const flutter_widgets.Locale('ru'));
  }

  @override
  bool shouldReload(ModernFallbackCupertinoLocalizationsDelegate old) => false;
}

/// Fallback for Flutter SDK's [MaterialLocalizations]
class FallbackMaterialLocalizationsDelegate
    extends flutter_widgets.LocalizationsDelegate<flutter_material.MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(flutter_widgets.Locale locale) => true;

  @override
  Future<flutter_material.MaterialLocalizations> load(flutter_widgets.Locale locale) {
    if (flutter_l10n.GlobalMaterialLocalizations.delegate.isSupported(locale)) {
      return flutter_l10n.GlobalMaterialLocalizations.delegate.load(locale);
    }
    return flutter_l10n.GlobalMaterialLocalizations.delegate.load(const flutter_widgets.Locale('ru'));
  }

  @override
  bool shouldReload(FallbackMaterialLocalizationsDelegate old) => false;
}

/// Fallback for Flutter SDK's [CupertinoLocalizations]
class FallbackCupertinoLocalizationsDelegate
    extends flutter_widgets.LocalizationsDelegate<flutter_cupertino.CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(flutter_widgets.Locale locale) => true;

  @override
  Future<flutter_cupertino.CupertinoLocalizations> load(flutter_widgets.Locale locale) {
    if (flutter_l10n.GlobalCupertinoLocalizations.delegate.isSupported(locale)) {
      return flutter_l10n.GlobalCupertinoLocalizations.delegate.load(locale);
    }
    return flutter_l10n.GlobalCupertinoLocalizations.delegate.load(const flutter_widgets.Locale('ru'));
  }

  @override
  bool shouldReload(FallbackCupertinoLocalizationsDelegate old) => false;
}

/// Fallback for Flutter SDK's [WidgetsLocalizations]
class FallbackWidgetsLocalizationsDelegate
    extends flutter_widgets.LocalizationsDelegate<flutter_widgets.WidgetsLocalizations> {
  const FallbackWidgetsLocalizationsDelegate();

  @override
  bool isSupported(flutter_widgets.Locale locale) => true;

  @override
  Future<flutter_widgets.WidgetsLocalizations> load(flutter_widgets.Locale locale) {
    if (flutter_l10n.GlobalWidgetsLocalizations.delegate.isSupported(locale)) {
      return flutter_l10n.GlobalWidgetsLocalizations.delegate.load(locale);
    }
    return flutter_l10n.GlobalWidgetsLocalizations.delegate.load(const flutter_widgets.Locale('ru'));
  }

  @override
  bool shouldReload(FallbackWidgetsLocalizationsDelegate old) => false;
}
