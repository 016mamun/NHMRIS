import 'package:flutter_bloc/flutter_bloc.dart';

String globalLanguage = 'বাংলা';

class LanguageCubit extends Cubit<String> {
  LanguageCubit() : super('বাংলা') {
    globalLanguage = 'বাংলা';
  }

  void changeLanguage(String language) {
    globalLanguage = language;
    emit(language);
  }
}
