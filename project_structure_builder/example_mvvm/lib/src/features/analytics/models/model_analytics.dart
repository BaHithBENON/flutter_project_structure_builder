import '../../../core/resources/database_attributes_resources.dart';
/// A model class for the feature [analytics].
///
/// This class is a view model for the feature [analytics].
/// It has a constructor with optional parameters and implements the [toJson],
/// [fromJson], and [copyWith] methods.
class ModelAnalytics extends Equatable  {

/// The fields of the model.
  final int? id;
  final String? eventName;
  final dynamic eventData;
  final DateTime? timestamp;

/// The constructor of the model.
/// 
/// The constructor takes a map of attributes as a parameter and returns an instance of the model.
  const ModelAnalytics({ this.id, this.eventName, this.eventData, this.timestamp });

/// Creates a new instance of the model from a map.
/// 
/// The map must contain the following keys: [attributes].
/// 
/// Returns a new instance of the model.
  factory ModelAnalytics.fromJson(Map<String, dynamic> json) {
    return ModelAnalytics(
      id: json[DatabaseAttributesResources.id],
      eventName: json[DatabaseAttributesResources.eventName],
      eventData: json[DatabaseAttributesResources.eventData],
      timestamp: json[DatabaseAttributesResources.timestamp],
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
      DatabaseAttributesResources.eventName: eventName,
      DatabaseAttributesResources.eventData: eventData,
      DatabaseAttributesResources.timestamp: timestamp,
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
      DatabaseAttributesResources.eventName: eventName,
      DatabaseAttributesResources.eventData: eventData,
      DatabaseAttributesResources.timestamp: timestamp,
    };
  }

/// Creates a new instance of the model with the given attributes.
/// 
/// The attributes are optional.
/// 
/// Returns a new instance of the model with the given attributes.
  ModelAnalytics copyWith({ int? id, String? eventName, dynamic eventData, DateTime? timestamp }) {
    return ModelAnalytics(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      eventData: eventData ?? this.eventData,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [
    id,
    eventName,
    eventData,
    timestamp
  ];
}
