part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class Authenticate extends AuthEvent {}

class LogOut extends AuthEvent {}
