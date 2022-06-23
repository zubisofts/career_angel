import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

   static const String themeKey = "APP_THEME_KEY";

  get getAppTheme async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isDark = pref.getBool(themeKey);
    emit(ThemeState(isDark ?? false));
  }

  void setAppTheme(bool value) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(themeKey, value);
    emit(ThemeState(value));
  }
}
