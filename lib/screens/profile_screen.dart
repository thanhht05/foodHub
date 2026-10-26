import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/bloc/auth/auth_bloc.dart';
import 'package:my_first_app/bloc/auth/auth_event.dart';
import 'package:my_first_app/bloc/auth/auth_state.dart';

import 'login_screen.dart';

/// Màn hình Tài khoản & Cài đặt (Profile Screen)
class ProfileScreen extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const ProfileScreen({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = themeNotifier.value == ThemeMode.dark;

    final authState = context.watch<AuthBloc>().state;
    final username = authState is AuthAuthenticated
        ? authState.user.fullName
        : "Gues";
    final email = authState is AuthAuthenticated
        ? authState.user.email
        : "chua_dang_nhap@foodhub.com";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản của tôi'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar & Tên người dùng
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 46,
                        backgroundColor: theme.colorScheme.primary.withValues(
                          alpha: 0.2,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 52,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: theme.colorScheme.primary,
                          child: const Icon(
                            Icons.camera_alt,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    username,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Các mục cài đặt
            _buildSettingSection(
              title: 'Cài đặt giao diện',
              children: [
                ListTile(
                  leading: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    color: theme.colorScheme.primary,
                  ),
                  title: const Text('Chế độ tối (Dark Mode)'),
                  trailing: Switch(
                    value: isDark,
                    activeThumbColor: theme.colorScheme.primary,
                    onChanged: (val) {
                      themeNotifier.value = val
                          ? ThemeMode.dark
                          : ThemeMode.light;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildSettingSection(
              title: 'Tài khoản & Đơn hàng',
              children: [
                _buildListTile(
                  icon: Icons.history,
                  title: 'Lịch sử đơn hàng',
                  subtitle: '5 đơn hàng đã hoàn thành',
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.location_on_outlined,
                  title: 'Địa chỉ giao hàng',
                  subtitle: 'Tòa nhà Landmark 81, TP. HCM',
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.payment_outlined,
                  title: 'Phương thức thanh toán',
                  subtitle: 'Ví MoMo, Tiền mặt',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Nút Đăng xuất
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  side: const BorderSide(color: Colors.redAccent),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Đăng Xuất'),
                onPressed: () {
                  context.read<AuthBloc>().add(const LogoutRequestedEvent());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
