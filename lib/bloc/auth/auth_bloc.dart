/*
Nó đóng vai trò như người gác cổng bảo mật:

Nhận sự kiện đăng nhập LoginSubmittedEvent(email, password).
Bắn ra AuthLoading (để nút đăng nhập hiện vòng xoay).
Đợi một chút giả lập gọi mạng (Future.delayed), 
  rồi so sánh tài khoản với mockUserAccounts trong mock_data.dart.
Nếu đúng: Bắn ra AuthAuthenticated(user: ...).
Nếu sai: Bắn ra AuthFailure(errorMessage: '...').
Khi nhận LogoutRequestedEvent ➔ Bắn ra AuthUnauthenticated.
*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/bloc/auth/auth_event.dart';
import 'package:my_first_app/bloc/auth/auth_state.dart';
import 'package:my_first_app/data/mock_data.dart';
import 'package:my_first_app/models/user_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Trạng thái ban đầu: AuthInitial (hoặc AuthUnauthenticated)
  AuthBloc() : super(const AuthInitial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<LogoutRequestedEvent>(_onLogoutRequested);
  }

  // 1. Kiểm tra trạng thái khi khởi động
  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Giả lập đợi 300ms kiểm tra token
    await Future.delayed(const Duration(milliseconds: 300));
    // Ban đầu người dùng chưa đăng nhập:
    emit(const AuthUnauthenticated());
  }

  // 2. Xử lý khi người dùng bấm Đăng nhập
  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Bước 1: Phát trạng thái đang tải (Loading)
    emit(const AuthLoading());
    // Giả lập độ trễ mạng 800ms
    await Future.delayed(const Duration(milliseconds: 800));

    final matchedAccount = mockUserAccounts.cast<MockUserAccount?>().firstWhere(
      (account) =>
          account?.email.trim().toLowerCase() ==
              event.email.trim().toLowerCase() &&
          account?.password == event.password,
      orElse: () => null,
    );

    if (matchedAccount != null) {
      // login successfully
      final user = UserModel(
        email: matchedAccount.email,
        fullName: matchedAccount.fullName,
      );
      emit(AuthAuthenticated(user: user));
    } else {
      // Sai email hoặc mật khẩu!
      emit(
        const AuthFailure(errorMessage: 'Email hoặc mật khẩu không chính xác!'),
      );
    }
  }

  // 3. Xử lý khi người dùng bấm Đăng xuất
  void _onLogoutRequested(LogoutRequestedEvent event, Emitter<AuthState> emit) {
    emit(const AuthUnauthenticated());
  }
}
