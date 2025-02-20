import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_user_profile.dart';

/// A class that extends [Entity] and overrides the [toJson] and [copyWith] methods
class ModelUserProfile extends EntityUserProfile {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelUserProfile({ super.id, super.username, super.profilePicture, super.bio });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelUserProfile.fromJson(Map<String, dynamic> json) {
    return ModelUserProfile(
      id: json[DatabaseAttributesResources.id],
      username: json[DatabaseAttributesResources.username],
      profilePicture: json[DatabaseAttributesResources.profilePicture],
      bio: json[DatabaseAttributesResources.bio],
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.username: username,
      DatabaseAttributesResources.profilePicture: profilePicture,
      DatabaseAttributesResources.bio: bio,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.username: username,
      DatabaseAttributesResources.profilePicture: profilePicture,
      DatabaseAttributesResources.bio: bio,
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory ModelUserProfile.fromEntity(EntityUserProfile entity) {
    return ModelUserProfile(
      id: entity.id,
      username: entity.username,
      profilePicture: entity.profilePicture,
      bio: entity.bio,
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  EntityUserProfile toEntity() {
    return EntityUserProfile(
      id: id,
      username: username,
      profilePicture: profilePicture,
      bio: bio,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelUserProfile copyWith(
    { int? id, String? username, String? profilePicture, String? bio }
  ) {
    return ModelUserProfile(
      id: id ?? this.id,
      username: username ?? this.username,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
    );
  }
}
