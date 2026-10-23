import 'package:flutter/material.dart';
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

  // Giỏ hàng dùng chung giữa các màn hình
  final List<CartItem> _sharedCart = [];

  int get _totalCartCount {
    return _sharedCart.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Danh sách các màn hình tương ứng với từng Tab
    final screens = [
      HomeScreen(
        cartItems: _sharedCart,
        themeNotifier: widget.themeNotifier,
      ),
      CartScreen(
        cartItems: _sharedCart,
        onBrowseFoods: () {
          setState(() => _currentIndex = 0);
        },
      ),
      ProfileScreen(
        themeNotifier: widget.themeNotifier,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
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
              icon: Badge(
                isLabelVisible: _totalCartCount > 0,
                label: Text('$_totalCartCount'),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              selectedIcon: Badge(
                isLabelVisible: _totalCartCount > 0,
                label: Text('$_totalCartCount'),
                child: const Icon(Icons.shopping_bag),
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
