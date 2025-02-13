import '../../../core/resources/database_attributes_resources.dart';
/// A model class for the feature [user_profile].
///
/// This class is a view model for the feature [user_profile].
/// It has a constructor with optional parameters and implements the [toJson],
/// [fromJson], and [copyWith] methods.
class ModelUserProfile extends Equatable  {

/// The fields of the model.
  final int? id;
  final String? username;
  final String? profilePicture;
  final String? bio;

/// The constructor of the model.
/// 
/// The constructor takes a map of attributes as a parameter and returns an instance of the model.
  const ModelUserProfile({ this.id, this.username, this.profilePicture, this.bio });

/// Creates a new instance of the model from a map.
/// 
/// The map must contain the following keys: [attributes].
/// 
/// Returns a new instance of the model.
  factory ModelUserProfile.fromJson(Map<String, dynamic> json) {
    return ModelUserProfile(
      id: json[DatabaseAttributesResources.id],
      username: json[DatabaseAttributesResources.username],
      profilePicture: json[DatabaseAttributesResources.profilePicture],
      bio: json[DatabaseAttributesResources.bio],
    );
  }

/// Converts the model to a map.
/// 
/// The map contains the fields of the model.
/// 
/// Returns a map of the fields of the model.
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.username: username,
      DatabaseAttributesResources.profilePicture: profilePicture,
      DatabaseAttributesResources.bio: bio,
    };
  }

/// Converts the model to a map without the id.
/// 
/// The map contains the fields of the model without the id.
/// 
/// Returns a map of the fields of the model without the id.
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.username: username,
      DatabaseAttributesResources.profilePicture: profilePicture,
      DatabaseAttributesResources.bio: bio,
    };
  }

/// Creates a new instance of the model with the given attributes.
/// 
/// The attributes are optional.
/// 
/// Returns a new instance of the model with the given attributes.
  ModelUserProfile copyWith({ int? id, String? username, String? profilePicture, String? bio }) {
    return ModelUserProfile(
      id: id ?? this.id,
      username: username ?? this.username,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
    );
  }

  @override
  List<Object?> get props => [
    id,
    username,
    profilePicture,
    bio
  ];
}
