import 'package:equatable/equatable.dart';
import '../../../core/resources/database_attributes_resources.dart';

/// A model for the feature [feature].
class ModelAnalytics extends Equatable  {

  final int? id;
  final String? eventName;
  final dynamic eventData;
  final DateTime? timestamp;

  /// Constructor for the model.
  const ModelAnalytics({ this.id, this.eventName, this.eventData, this.timestamp });

  /// Factory constructor for the model from a json map.
  factory ModelAnalytics.fromJson(Map<String, dynamic> json) {
    return ModelAnalytics(
      id: json[DatabaseAttributesResources.id],
      eventName: json[DatabaseAttributesResources.eventName],
      eventData: json[DatabaseAttributesResources.eventData],
      timestamp: json[DatabaseAttributesResources.timestamp],
    );
  }

  /// Converts the model to a json map.
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.eventName: eventName,
      DatabaseAttributesResources.eventData: eventData,
      DatabaseAttributesResources.timestamp: timestamp,
    };
  }

  /// Converts the model to a json map without the id.
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.eventName: eventName,
      DatabaseAttributesResources.eventData: eventData,
      DatabaseAttributesResources.timestamp: timestamp,
    };
  }

  /// Creates a new instance of the model with the given attributes.
  ModelAnalytics copyWith({ int? id, String? eventName, dynamic eventData, DateTime? timestamp }) {
    return ModelAnalytics(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      eventData: eventData ?? this.eventData,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// List of props for the [Equatable] class.
  @override
  List<Object?> get props => [
    id,
    eventName,
    eventData,
    timestamp
  ];
}
