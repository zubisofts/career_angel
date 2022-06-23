import 'package:career_path/domain/cubits/app_cubit/app_cubit.dart';
import 'package:career_path/presentation/theme/app_theme.dart';
import 'package:career_path/presentation/views/screens/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AppCubit _appCubit = AppCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _appCubit,
      child: BlocBuilder<AppCubit, AppState>(
        bloc: _appCubit..getAppTheme,
        buildWhen: (_, state) => state is ThemeState,
        builder: (context, state) {
          bool isDark = false;
          if (state is ThemeState) {
            isDark = state.isDark;
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Career Angel ✨',
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
