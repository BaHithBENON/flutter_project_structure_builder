import 'package:equatable/equatable.dart';

class EntityUserProfile extends Equatable {
  final int? id;
  final String? username;
  final String? profilePicture;
  final String? bio;

  // Const constructor allowing optional named parameters.
  const EntityUserProfile({ this.id, this.username, this.profilePicture, this.bio });

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    id,
    username,
    profilePicture,
    bio
  ];
}
