import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_analytics.dart';

/// A class that extends [Entity] and overrides the [toJson] and [copyWith] methods
class ModelAnalytics extends EntityAnalytics {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelAnalytics({ super.id, super.eventName, super.eventData, super.timestamp });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelAnalytics.fromJson(Map<String, dynamic> json) {
    return ModelAnalytics(
      id: json[DatabaseAttributesResources.id],
      eventName: json[DatabaseAttributesResources.eventName],
      eventData: json[DatabaseAttributesResources.eventData],
      timestamp: json[DatabaseAttributesResources.timestamp],
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.eventName: eventName,
      DatabaseAttributesResources.eventData: eventData,
      DatabaseAttributesResources.timestamp: timestamp,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.eventName: eventName,
      DatabaseAttributesResources.eventData: eventData,
      DatabaseAttributesResources.timestamp: timestamp,
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory ModelAnalytics.fromEntity(EntityAnalytics entity) {
    return ModelAnalytics(
      id: entity.id,
      eventName: entity.eventName,
      eventData: entity.eventData,
      timestamp: entity.timestamp,
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  EntityAnalytics toEntity() {
    return EntityAnalytics(
      id: id,
      eventName: eventName,
      eventData: eventData,
      timestamp: timestamp,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelAnalytics copyWith(
    { int? id, String? eventName, dynamic eventData, DateTime? timestamp }
  ) {
    return ModelAnalytics(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      eventData: eventData ?? this.eventData,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
