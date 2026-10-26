import 'package:equatable/equatable.dart';
import 'package:my_first_app/models/user_model.dart';

/*

  AuthInitial: App vừa mở lên, chưa xác định.

  
AuthLoading: Đang xoay vòng tròn kiểm tra email & mật khẩu.

  
AuthAuthenticated: Đăng nhập thành công, kèm theo dữ liệu UserModel user (tên, email).

  
AuthUnauthenticated: Chưa đăng nhập (hoặc vừa bấm Đăng xuất).

  
AuthFailure: Đăng nhập thất bại, kèm theo câu thông báo lỗi errorMessage 
*/

/// Lớp cơ sở (Base Class) cho tất cả trạng thái xác thực
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

/// 1. Trạng thái khởi đầu khi vừa mở app
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// 2. Trạng thái đang xử lý đăng nhập (xoay vòng loading)
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// 3. Trạng thái Đăng nhập thành công (chứa thông tin người dùng)
class AuthAuthenticated extends AuthState {
  final UserModel user;
  const AuthAuthenticated({required this.user});
  @override
  List<Object?> get props => [user];
}

/// 4. Trạng thái Chưa đăng nhập (hoặc vừa bấm Đăng xuất)
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// 5. Trạng thái Đăng nhập thất bại (chứa câu thông báo lỗi)
class AuthFailure extends AuthState {
  final String errorMessage;
  const AuthFailure({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
