import 'package:equatable/equatable.dart';
import '../../../core/resources/database_attributes_resources.dart';

/// A model for the feature [feature].
class ModelAuthentication extends Equatable  {

  final String? email;
  final String? otp;
  final String? password;
  final String? token;
  final int? id;

  /// Constructor for the model.
  const ModelAuthentication({ this.email, this.otp, this.password, this.token, this.id });

  /// Factory constructor for the model from a json map.
  factory ModelAuthentication.fromJson(Map<String, dynamic> json) {
    return ModelAuthentication(
      email: json[DatabaseAttributesResources.email],
      otp: json[DatabaseAttributesResources.otp],
      password: json[DatabaseAttributesResources.password],
      token: json[DatabaseAttributesResources.token],
      id: json[DatabaseAttributesResources.id],
    );
  }

  /// Converts the model to a json map.
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.email: email,
      DatabaseAttributesResources.otp: otp,
      DatabaseAttributesResources.password: password,
      DatabaseAttributesResources.token: token,
      DatabaseAttributesResources.id: id,
    };
  }

  /// Converts the model to a json map without the id.
  Map<String, dynamic> toJsonWithoutId() {
    return {
      DatabaseAttributesResources.email: email,
      DatabaseAttributesResources.otp: otp,
      DatabaseAttributesResources.password: password,
      DatabaseAttributesResources.token: token,
      // DatabaseAttributesResources.id: id,
    };
  }

  /// Creates a new instance of the model with the given attributes.
  ModelAuthentication copyWith({ String? email, String? otp, String? password, String? token, int? id }) {
    return ModelAuthentication(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      password: password ?? this.password,
      token: token ?? this.token,
      id: id ?? this.id,
    );
  }

  /// List of props for the [Equatable] class.
  @override
  List<Object?> get props => [
    email,
    otp,
    password,
    token,
    id
  ];
}
