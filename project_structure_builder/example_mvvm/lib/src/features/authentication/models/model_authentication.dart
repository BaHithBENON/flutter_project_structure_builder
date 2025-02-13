import '../../../core/resources/database_attributes_resources.dart';
/// A model class for the feature [authentication].
///
/// This class is a view model for the feature [authentication].
/// It has a constructor with optional parameters and implements the [toJson],
/// [fromJson], and [copyWith] methods.
class ModelAuthentication extends Equatable  {

/// The fields of the model.
  final String? email;
  final String? otp;
  final String? password;
  final String? token;
  final int? id;

/// The constructor of the model.
/// 
/// The constructor takes a map of attributes as a parameter and returns an instance of the model.
  const ModelAuthentication({ this.email, this.otp, this.password, this.token, this.id });

/// Creates a new instance of the model from a map.
/// 
/// The map must contain the following keys: [attributes].
/// 
/// Returns a new instance of the model.
  factory ModelAuthentication.fromJson(Map<String, dynamic> json) {
    return ModelAuthentication(
      email: json[DatabaseAttributesResources.email],
      otp: json[DatabaseAttributesResources.otp],
      password: json[DatabaseAttributesResources.password],
      token: json[DatabaseAttributesResources.token],
      id: json[DatabaseAttributesResources.id],
    );
  }

/// Converts the model to a map.
/// 
/// The map contains the fields of the model.
/// 
/// Returns a map of the fields of the model.
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.email: email,
      DatabaseAttributesResources.otp: otp,
      DatabaseAttributesResources.password: password,
      DatabaseAttributesResources.token: token,
      DatabaseAttributesResources.id: id,
    };
  }

/// Converts the model to a map without the id.
/// 
/// The map contains the fields of the model without the id.
/// 
/// Returns a map of the fields of the model without the id.
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
/// 
/// The attributes are optional.
/// 
/// Returns a new instance of the model with the given attributes.
  ModelAuthentication copyWith({ String? email, String? otp, String? password, String? token, int? id }) {
    return ModelAuthentication(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      password: password ?? this.password,
      token: token ?? this.token,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
    email,
    otp,
    password,
    token,
    id
  ];
}
