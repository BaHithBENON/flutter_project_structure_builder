import 'package:equatable/equatable.dart';
import '../../../core/resources/database_attributes_resources.dart';

/// A model for the feature [feature].
class ModelUserProfile extends Equatable  {

  final int? id;
  final String? username;
  final String? profilePicture;
  final String? bio;

  /// Constructor for the model.
  const ModelUserProfile({ this.id, this.username, this.profilePicture, this.bio });

  /// Factory constructor for the model from a json map.
  factory ModelUserProfile.fromJson(Map<String, dynamic> json) {
    return ModelUserProfile(
      id: json[DatabaseAttributesResources.id],
      username: json[DatabaseAttributesResources.username],
      profilePicture: json[DatabaseAttributesResources.profilePicture],
      bio: json[DatabaseAttributesResources.bio],
    );
  }

  /// Converts the model to a json map.
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.username: username,
      DatabaseAttributesResources.profilePicture: profilePicture,
      DatabaseAttributesResources.bio: bio,
    };
  }

  /// Converts the model to a json map without the id.
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.username: username,
      DatabaseAttributesResources.profilePicture: profilePicture,
      DatabaseAttributesResources.bio: bio,
    };
  }

  /// Creates a new instance of the model with the given attributes.
  ModelUserProfile copyWith({ int? id, String? username, String? profilePicture, String? bio }) {
    return ModelUserProfile(
      id: id ?? this.id,
      username: username ?? this.username,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
    );
  }

  /// List of props for the [Equatable] class.
  @override
  List<Object?> get props => [
    id,
    username,
    profilePicture,
    bio
  ];
}
