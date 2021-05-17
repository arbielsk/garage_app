import 'dart:convert';

class Vehicle {
  final String vin;
  final String displayName;
  final String model;

  Vehicle({
    required this.vin,
    required this.displayName,
    required this.model,
  });

  Vehicle copyWith({
    String? vin,
    String? displayName,
    String? model,
  }) {
    return Vehicle(
      vin: vin ?? this.vin,
      displayName: displayName ?? this.displayName,
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vin': vin,
      'displayName': displayName,
      'model': model,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      vin: map['vin'],
      displayName: map['displayName'],
      model: map['model'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) =>
      Vehicle.fromMap(json.decode(source));

  @override
  String toString() =>
      'Vehicle(vin: $vin, displayName: $displayName, model: $model)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vehicle &&
        other.vin == vin &&
        other.displayName == displayName &&
        other.model == model;
  }

  @override
  int get hashCode => vin.hashCode ^ displayName.hashCode ^ model.hashCode;
}
