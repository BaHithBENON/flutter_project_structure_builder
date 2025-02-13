import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_settings.dart';

/// A class that extends [Entity] and overrides the [toJson] and [copyWith] methods
class ModelSettings extends EntitySettings {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelSettings({ super.notificationsEnabled, super.language, super.theme });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelSettings.fromJson(Map<String, dynamic> json) {
    return ModelSettings(
      notificationsEnabled: json[DatabaseAttributesResources.notificationsEnabled],
      language: json[DatabaseAttributesResources.language],
      theme: json[DatabaseAttributesResources.theme],
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.notificationsEnabled: notificationsEnabled,
      DatabaseAttributesResources.language: language,
      DatabaseAttributesResources.theme: theme,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      DatabaseAttributesResources.notificationsEnabled: notificationsEnabled,
      DatabaseAttributesResources.language: language,
      DatabaseAttributesResources.theme: theme,
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory ModelSettings.fromEntity(EntitySettings entity) {
    return ModelSettings(
      notificationsEnabled: entity.notificationsEnabled,
      language: entity.language,
      theme: entity.theme,
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  EntitySettings toEntity() {
    return EntitySettings(
      notificationsEnabled: notificationsEnabled,
      language: language,
      theme: theme,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelSettings copyWith(
    { bool? notificationsEnabled, String? language, String? theme }
  ) {
    return ModelSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      language: language ?? this.language,
      theme: theme ?? this.theme,
    );
  }
}
