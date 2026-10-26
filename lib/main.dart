import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/bloc/auth/auth_bloc.dart';
import 'package:my_first_app/bloc/auth/auth_event.dart';
import 'package:my_first_app/bloc/auth/auth_state.dart';
import 'package:my_first_app/bloc/cart/cart_bloc.dart';
import 'package:my_first_app/screens/main_navigation_screen.dart';

import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() {
  // Điểm khởi đầu của ứng dụng Flutter
  runApp(const FoodHubApp());
}

/// Ứng dụng gốc (Root Widget)
class FoodHubApp extends StatefulWidget {
  const FoodHubApp({super.key});

  @override
  State<FoodHubApp> createState() => _FoodHubAppState();
}

class _FoodHubAppState extends State<FoodHubApp> {
  // ValueNotifier dùng để lắng nghe và chuyển đổi ThemeMode (Sáng / Tối) tức thì
  final ValueNotifier<ThemeMode> _themeNotifier = ValueNotifier<ThemeMode>(
    ThemeMode.light,
  );

  @override
  void dispose() {
    _themeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(
          create: (context) => AuthBloc()..add(const CheckAuthStatusEvent()),
        ),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: _themeNotifier,
        builder: (context, currentMode, child) {
          return MaterialApp(
            title: 'FoodHub',
            debugShowCheckedModeBanner: false,
            // Áp dụng chủ đề giao diện Sáng / Tối
            theme: AppTheme.lightTheme,

            darkTheme: AppTheme.darkTheme,
            themeMode: currentMode,
            // Màn hình khởi chạy đầu tiên là Đăng nhập
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return MainNavigationScreen(themeNotifier: _themeNotifier);
                }
                return LoginScreen(themeNotifier: _themeNotifier);
              },
            ),
          );
        },
      ),
    );
  }
}
