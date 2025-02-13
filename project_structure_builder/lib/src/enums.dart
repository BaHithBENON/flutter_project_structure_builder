enum ArchitectureTypes {
  cleanArchitecture("Clean Architecture", "clean_architecture"),
  mvcArchitecture("MVC Architecture", "mvc_architecture"),
  mvvmArchitecture("MVVM Architecture", "mvvm_architecture"),
  ;

  final String name;
  final String value;

  const ArchitectureTypes(this.name, this.value);

  factory ArchitectureTypes.fromValue(String? type) {
    return ArchitectureTypes.values.firstWhere(
      (element) => element.value == type,
      orElse: () => ArchitectureTypes.cleanArchitecture,
    );
  }
}

enum FeaturesStrategy {
  inLib(name: "In lib", value: "inLib", explanation: "Fonctionnalités dans le dossier lib/features"),
  independantModules(name: "Independant modules", value: "independantModules", explanation: "Fonctionnalités dans des modules indépendants"),
  ;

  final String name;
  final String value; 
  final String explanation;

  const FeaturesStrategy({required this.name, required this.value, required this.explanation});

  factory FeaturesStrategy.fromValue(String? type) {
    return FeaturesStrategy.values.firstWhere(
      (element) => element.value == type,
      orElse: () => FeaturesStrategy.inLib,
    );
  }
}

enum UseCaseType {
  future("Future", "UseCase"),
  simpleFuture("SimpleFuture", "SimpleUseCase"),
  stream("Stream", "StreamUseCase"),
  simpleStream("SimpleStream", "SimpleStreamUseCase"),
  ;

  final String value;
  final String target;
  const UseCaseType(this.value, this.target);

  factory UseCaseType.fromValue(String? type) {
    return UseCaseType.values.firstWhere(
      (element) => element.value == type,
      orElse: () => UseCaseType.future,
    );
  }
}

enum HttpMethod {
  get("GET"),
  post("POST"),
  put("PUT"),
  delete("DELETE"),
  patch("PATCH"),
  head("HEAD"),
  options("OPTIONS"),
  ;

  final String value;
  const HttpMethod(this.value);
}

enum DartDataType {
  string("String", "String"),
  int("int", "int"),
  double("double", "double"),
  num("num", "num"),
  bool("bool", "bool"),
  list("List", "List<dynamic>"),
  set("Set", "Set<dynamic>"),
  map("Map", "Map<String, dynamic>"),
  record("Record", "({dynamic})"),
  function("Function", "Function"),
  future("Future", "Future<dynamic>"),
  stream("Stream", "Stream<dynamic>"),
  dateTime("DateTime", "DateTime"),
  duration("Duration", "Duration"),
  object("Object", "Object"),
  dynamicType("dynamic", "dynamic"),
  voidType("void", "void"),
  nullType("Null", "Null");

  final String value;
  final String target;

  const DartDataType(this.value, this.target);

  factory DartDataType.fromValue(String? type) {
    return DartDataType.values.firstWhere(
      (element) => element.value == type,
      orElse: () => DartDataType.dynamicType,
    );
  }

  
}

enum StateManagementTypes {
  none("None", "none"),
  provider("Provider", "provider"),
  cubit("Cubit", "cubit"),
  bloc("Bloc", "bloc"),
  getX("GetX", "getx"),
  mobX("MobX", "mobx"),
  riverpod("Riverpod", "riverpod"),
  ;

  final String name;
  final String value;

  const StateManagementTypes(this.name, this.value);

  factory StateManagementTypes.fromValue(String? type) {
    return StateManagementTypes.values.firstWhere(
      (element) => element.value == type,
      orElse: () => StateManagementTypes.getX,
    );
  }
  
  bool get isGetX => value == "getx";
  bool get isProvider => value == "provider";
  bool get isCubit => value == "cubit";
  bool get isBloc => value == "bloc";
  bool get isMobX => value == "mobx";
  bool get isRiverpod => value == "riverpod";
  bool get isNone => value == "none";
}