import 'package:equatable/equatable.dart';

/*
 Nghĩ xem người dùng có thể tạo ra những sự kiện gì liên quan đến tài khoản:

Bấm nút "Đăng nhập" kèm email và mật khẩu (LoginSubmittedEvent).
Bấm nút "Đăng xuất" (LogoutRequestedEvent).
Ứng dụng vừa bật lên cần kiểm tra xem người dùng đã đăng nhập từ trước chưa 

*/

/// Lớp cơ sở (Base Class) cho tất cả sự kiện liên quan đến Xác thực
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

/// 1. Sự kiện: Ứng dụng khởi động, kiểm tra trạng thái đăng nhập
class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

/// 2. Sự kiện: Người dùng bấm nút Đăng nhập (gửi email & mật khẩu)
class LoginSubmittedEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginSubmittedEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

/// 3. Sự kiện: Người dùng bấm Đăng xuất
class LogoutRequestedEvent extends AuthEvent {
  const LogoutRequestedEvent();
}
