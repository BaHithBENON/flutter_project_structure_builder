import '../../../core/resources/database_attributes_resources.dart';
/// A model class for the feature [settings].
///
/// This class is a view model for the feature [settings].
/// It has a constructor with optional parameters and implements the [toJson],
/// [fromJson], and [copyWith] methods.
class ModelSettings extends Equatable  {

/// The fields of the model.
  final bool? notificationsEnabled;
  final String? language;
  final String? theme;

/// The constructor of the model.
/// 
/// The constructor takes a map of attributes as a parameter and returns an instance of the model.
  const ModelSettings({ this.notificationsEnabled, this.language, this.theme });

/// Creates a new instance of the model from a map.
/// 
/// The map must contain the following keys: [attributes].
/// 
/// Returns a new instance of the model.
  factory ModelSettings.fromJson(Map<String, dynamic> json) {
    return ModelSettings(
      notificationsEnabled: json[DatabaseAttributesResources.notificationsEnabled],
      language: json[DatabaseAttributesResources.language],
      theme: json[DatabaseAttributesResources.theme],
    );
  }

/// Converts the model to a map.
/// 
/// The map contains the fields of the model.
/// 
/// Returns a map of the fields of the model.
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.notificationsEnabled: notificationsEnabled,
      DatabaseAttributesResources.language: language,
      DatabaseAttributesResources.theme: theme,
    };
  }

/// Converts the model to a map without the id.
/// 
/// The map contains the fields of the model without the id.
/// 
/// Returns a map of the fields of the model without the id.
  Map<String, dynamic> toJsonWithoutId() {
    return {
      DatabaseAttributesResources.notificationsEnabled: notificationsEnabled,
      DatabaseAttributesResources.language: language,
      DatabaseAttributesResources.theme: theme,
    };
  }

/// Creates a new instance of the model with the given attributes.
/// 
/// The attributes are optional.
/// 
/// Returns a new instance of the model with the given attributes.
  ModelSettings copyWith({ bool? notificationsEnabled, String? language, String? theme }) {
    return ModelSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      language: language ?? this.language,
      theme: theme ?? this.theme,
    );
  }

  @override
  List<Object?> get props => [
    notificationsEnabled,
    language,
    theme
  ];
}
