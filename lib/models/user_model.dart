import 'package:equatable/equatable.dart';

/// Model thông tin người dùng đã đăng nhập
class UserModel extends Equatable {
  final String email;
  final String fullName;
  final String? avatarUrl;

  const UserModel({
    required this.email,
    required this.fullName,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [email, fullName, avatarUrl];
}

