import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_state.dart';

import 'cart_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

/// Màn hình Khung Điều Hướng Chính (Chứa BottomNavigationBar)
class MainNavigationScreen extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const MainNavigationScreen({super.key, required this.themeNotifier});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Danh sách các màn hình tương ứng với từng Tab
    final screens = [
      HomeScreen(themeNotifier: widget.themeNotifier),
      CartScreen(
        onBrowseFoods: () {
          setState(() => _currentIndex = 0);
        },
      ),
      ProfileScreen(themeNotifier: widget.themeNotifier),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          indicatorColor: theme.colorScheme.primary.withValues(alpha: 0.18),
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            NavigationDestination(
              icon: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Badge(
                    isLabelVisible: state.totalCount > 0,
                    label: Text('${state.totalCount}'),
                    child: const Icon(Icons.shopping_bag_outlined),
                  );
                },
              ),
              selectedIcon: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Badge(
                    isLabelVisible: state.totalCount > 0,
                    label: Text('${state.totalCount}'),
                    child: const Icon(Icons.shopping_bag),
                  );
                },
              ),
              label: 'Giỏ hàng',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Tài khoản',
            ),
          ],
        ),
      ),
    );
  }
}
