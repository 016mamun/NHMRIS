// ── Auth BLoC ─────────────────────────────────────────────────────────────────
import 'package:equatable/equatable.dart';
import '../models/user_model.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String phone;
  final String password;
  const AuthLoginRequested({required this.phone, required this.password});
  @override
  List<Object?> get props => [phone, password];
}

class AuthRegisterRequested extends AuthEvent {
  final String name;
  final String phone;
  final String password;
  final int pregnancyWeeks;
  const AuthRegisterRequested({
    required this.name,
    required this.phone,
    required this.password,
    required this.pregnancyWeeks,
  });
  @override
  List<Object?> get props => [name, phone, password, pregnancyWeeks];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

class AuthProfileUpdated extends AuthEvent {
  final UserModel updatedUser;
  const AuthProfileUpdated({required this.updatedUser});
  @override
  List<Object?> get props => [updatedUser];
}
