import 'package:equatable/equatable.dart';
import '../../../core/resources/database_attributes_resources.dart';

/// A model for the feature [feature].
class ModelSettings extends Equatable  {

  final bool? notificationsEnabled;
  final String? language;
  final String? theme;

  /// Constructor for the model.
  const ModelSettings({ this.notificationsEnabled, this.language, this.theme });

  /// Factory constructor for the model from a json map.
  factory ModelSettings.fromJson(Map<String, dynamic> json) {
    return ModelSettings(
      notificationsEnabled: json[DatabaseAttributesResources.notificationsEnabled],
      language: json[DatabaseAttributesResources.language],
      theme: json[DatabaseAttributesResources.theme],
    );
  }

  /// Converts the model to a json map.
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.notificationsEnabled: notificationsEnabled,
      DatabaseAttributesResources.language: language,
      DatabaseAttributesResources.theme: theme,
    };
  }

  /// Converts the model to a json map without the id.
  Map<String, dynamic> toJsonWithoutId() {
    return {
      DatabaseAttributesResources.notificationsEnabled: notificationsEnabled,
      DatabaseAttributesResources.language: language,
      DatabaseAttributesResources.theme: theme,
    };
  }

  /// Creates a new instance of the model with the given attributes.
  ModelSettings copyWith({ bool? notificationsEnabled, String? language, String? theme }) {
    return ModelSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      language: language ?? this.language,
      theme: theme ?? this.theme,
    );
  }

  /// List of props for the [Equatable] class.
  @override
  List<Object?> get props => [
    notificationsEnabled,
    language,
    theme
  ];
}
