import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit() : super(ChangeLanguage(Locale("en")));

  changeLanguageToEnglish() {
    emit(ChangeLanguage(Locale("en")));
  }

  changeLanguageToArabic() {
    emit(ChangeLanguage(Locale("ar")));
  }
}