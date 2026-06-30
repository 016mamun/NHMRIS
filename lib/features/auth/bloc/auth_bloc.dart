import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';
import '../models/baby_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthProfileUpdated>(_onProfileUpdated);
  }

  Future<void> _onCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
      if (isLoggedIn) {
        final babiesJson = prefs.getString('user_babies');
        final List<BabyModel> babies = babiesJson != null 
          ? (jsonDecode(babiesJson) as List).map((b) => BabyModel.fromMap(Map<String, dynamic>.from(b))).toList()
          : [];

        final user = UserModel(
          id: prefs.getString('user_id') ?? '1',
          name: prefs.getString('user_name') ?? 'তাসনিয়া রহমান',
          phone: prefs.getString('user_phone') ?? '01700000000',
          pregnancyWeeks: prefs.getInt('pregnancy_weeks') ?? 0,
          profileImage: prefs.getString('user_profileImage'),
          dob: prefs.getString('user_dob'),
          bloodGroup: prefs.getString('user_bloodGroup'),
          occupation: prefs.getString('user_occupation'),
          addressHouseRoad: prefs.getString('user_addressHouseRoad'),
          addressArea: prefs.getString('user_addressArea'),
          addressPostOffice: prefs.getString('user_addressPostOffice'),
          addressThana: prefs.getString('user_addressThana'),
          addressDistrict: prefs.getString('user_addressDistrict'),
          addressPostCode: prefs.getString('user_addressPostCode'),
          husbandName: prefs.getString('user_husbandName'),
          husbandOccupation: prefs.getString('user_husbandOccupation'),
          husbandImage: prefs.getString('user_husbandImage'),
          currentLocation: prefs.getString('user_currentLocation'),
          regularResidence: prefs.getString('user_regularResidence'),
          alternativePhone: prefs.getString('user_alternativePhone'),
          babies: babies,
        );
        emit(AuthAuthenticated(user: user));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (_) {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _saveUserToPrefs(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('user_id', user.id);
    await prefs.setString('user_name', user.name);
    await prefs.setString('user_phone', user.phone);
    await prefs.setInt('pregnancy_weeks', user.pregnancyWeeks);
    if (user.profileImage != null) {
      await prefs.setString('user_profileImage', user.profileImage!);
    }
    if (user.dob != null) {
      await prefs.setString('user_dob', user.dob!);
    }
    if (user.bloodGroup != null) {
      await prefs.setString('user_bloodGroup', user.bloodGroup!);
    }
    if (user.occupation != null) {
      await prefs.setString('user_occupation', user.occupation!);
    }
    if (user.addressHouseRoad != null) {
      await prefs.setString('user_addressHouseRoad', user.addressHouseRoad!);
    }
    if (user.addressArea != null) {
      await prefs.setString('user_addressArea', user.addressArea!);
    }
    if (user.addressPostOffice != null) {
      await prefs.setString('user_addressPostOffice', user.addressPostOffice!);
    }
    if (user.addressThana != null) {
      await prefs.setString('user_addressThana', user.addressThana!);
    }
    if (user.addressDistrict != null) {
      await prefs.setString('user_addressDistrict', user.addressDistrict!);
    }
    if (user.addressPostCode != null) {
      await prefs.setString('user_addressPostCode', user.addressPostCode!);
    }
    if (user.husbandName != null) {
      await prefs.setString('user_husbandName', user.husbandName!);
    }
    if (user.husbandOccupation != null) {
      await prefs.setString('user_husbandOccupation', user.husbandOccupation!);
    }
    if (user.husbandImage != null) {
      await prefs.setString('user_husbandImage', user.husbandImage!);
    }
    if (user.currentLocation != null) {
      await prefs.setString('user_currentLocation', user.currentLocation!);
    }
    if (user.regularResidence != null) {
      await prefs.setString('user_regularResidence', user.regularResidence!);
    }
    if (user.alternativePhone != null) {
      await prefs.setString('user_alternativePhone', user.alternativePhone!);
    }
    await prefs.setString('user_babies', jsonEncode(user.babies.map((b) => b.toMap()).toList()));
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await Future.delayed(const Duration(milliseconds: 800));
    try {
      final phone = event.phone.isEmpty ? '01700000000' : event.phone;
      final user = UserModel(
        id: '1',
        name: 'তাসনিয়া রহমান',
        phone: phone,
        pregnancyWeeks: 0,
      );
      await _saveUserToPrefs(user);
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await Future.delayed(const Duration(milliseconds: 800));
    try {
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: event.name,
        phone: event.phone,
        pregnancyWeeks: event.pregnancyWeeks,
      );
      await _saveUserToPrefs(user);
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onProfileUpdated(
    AuthProfileUpdated event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _saveUserToPrefs(event.updatedUser);
      emit(AuthAuthenticated(user: event.updatedUser));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    emit(const AuthUnauthenticated());
  }
}
