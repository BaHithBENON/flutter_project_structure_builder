
/// A model class for the feature [notifications].
///
/// This class is a view model for the feature [notifications].
/// It has a constructor with optional parameters and implements the [toJson],
/// [fromJson], and [copyWith] methods.
class ModelNotifications extends Equatable  {

/// The fields of the model.


/// The constructor of the model.
/// 
/// The constructor takes a map of attributes as a parameter and returns an instance of the model.
  const ModelNotifications();

/// Creates a new instance of the model from a map.
/// 
/// The map must contain the following keys: [attributes].
/// 
/// Returns a new instance of the model.
  factory ModelNotifications.fromJson(Map<String, dynamic> json) {
    return ModelNotifications(
      
    );
  }

/// Converts the model to a map.
/// 
/// The map contains the fields of the model.
/// 
/// Returns a map of the fields of the model.
  Map<String, dynamic> toJson() {
    return {
      
    };
  }

/// Converts the model to a map without the id.
/// 
/// The map contains the fields of the model without the id.
/// 
/// Returns a map of the fields of the model without the id.
  Map<String, dynamic> toJsonWithoutId() {
    return {
      
    };
  }

/// Creates a new instance of the model with the given attributes.
/// 
/// The attributes are optional.
/// 
/// Returns a new instance of the model with the given attributes.
  ModelNotifications copyWith() {
    return ModelNotifications(
      
    );
  }

  @override
  List<Object?> get props => [
    
  ];
}
