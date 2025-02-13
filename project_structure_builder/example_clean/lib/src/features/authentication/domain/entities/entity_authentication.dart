import 'package:equatable/equatable.dart';

class EntityAuthentication extends Equatable {
  final String? email;
  final String? otp;
  final String? password;
  final String? token;
  final int? id;

  // Const constructor allowing optional named parameters.
  const EntityAuthentication({ this.email, this.otp, this.password, this.token, this.id });

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    email,
    otp,
    password,
    token,
    id
  ];
}
