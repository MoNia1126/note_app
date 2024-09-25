import 'dart:ui';

abstract class ChangeLanguageState {
  final Locale locale;
  ChangeLanguageState(this.locale);
}

final class ChangeLanguage extends ChangeLanguageState {
  ChangeLanguage(Locale locale):super(locale);

}