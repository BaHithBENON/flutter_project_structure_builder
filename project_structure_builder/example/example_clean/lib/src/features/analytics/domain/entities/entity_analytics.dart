import 'package:equatable/equatable.dart';

class EntityAnalytics extends Equatable {
  final int? id;
  final String? eventName;
  final dynamic eventData;
  final DateTime? timestamp;

  // Const constructor allowing optional named parameters.
  const EntityAnalytics({ this.id, this.eventName, this.eventData, this.timestamp });

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    id,
    eventName,
    eventData,
    timestamp
  ];
}
