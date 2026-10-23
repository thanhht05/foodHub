import 'package:flutter/material.dart';
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
  final ValueNotifier<ThemeMode> _themeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  @override
  void dispose() {
    _themeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
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
          home: LoginScreen(themeNotifier: _themeNotifier),
        );
      },
    );
  }
}
