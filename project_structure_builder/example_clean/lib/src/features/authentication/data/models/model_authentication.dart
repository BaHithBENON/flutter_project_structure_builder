import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_authentication.dart';

/// A class that extends [Entity] and overrides the [toJson] and [copyWith] methods
class ModelAuthentication extends EntityAuthentication {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelAuthentication({ super.email, super.otp, super.password, super.token, super.id });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelAuthentication.fromJson(Map<String, dynamic> json) {
    return ModelAuthentication(
      email: json[DatabaseAttributesResources.email],
      otp: json[DatabaseAttributesResources.otp],
      password: json[DatabaseAttributesResources.password],
      token: json[DatabaseAttributesResources.token],
      id: json[DatabaseAttributesResources.id],
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.email: email,
      DatabaseAttributesResources.otp: otp,
      DatabaseAttributesResources.password: password,
      DatabaseAttributesResources.token: token,
      DatabaseAttributesResources.id: id,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      DatabaseAttributesResources.email: email,
      DatabaseAttributesResources.otp: otp,
      DatabaseAttributesResources.password: password,
      DatabaseAttributesResources.token: token,
      // DatabaseAttributesResources.id: id,
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory ModelAuthentication.fromEntity(EntityAuthentication entity) {
    return ModelAuthentication(
      email: entity.email,
      otp: entity.otp,
      password: entity.password,
      token: entity.token,
      id: entity.id,
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  EntityAuthentication toEntity() {
    return EntityAuthentication(
      email: email,
      otp: otp,
      password: password,
      token: token,
      id: id,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelAuthentication copyWith(
    { String? email, String? otp, String? password, String? token, int? id }
  ) {
    return ModelAuthentication(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      password: password ?? this.password,
      token: token ?? this.token,
      id: id ?? this.id,
    );
  }
}
