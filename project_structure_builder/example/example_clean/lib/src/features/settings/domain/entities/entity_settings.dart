import 'package:equatable/equatable.dart';

class EntitySettings extends Equatable {
  final bool? notificationsEnabled;
  final String? language;
  final String? theme;

  // Const constructor allowing optional named parameters.
  const EntitySettings({ this.notificationsEnabled, this.language, this.theme });

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    notificationsEnabled,
    language,
    theme
  ];
}
