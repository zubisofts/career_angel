part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppInitial extends AppState {
  @override
  List<Object> get props => [];
}

class ThemeState extends AppState {
  final bool isDark;

  const ThemeState(this.isDark);

  @override
  List<Object?> get props => [isDark];
}
