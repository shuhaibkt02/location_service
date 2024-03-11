import 'package:flutter/foundation.dart';

@immutable
class LocationModel {
  final String placeholder;
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  const LocationModel({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.placeholder,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toString(),
      'placeholder':placeholder,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) => LocationModel(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      timestamp: DateTime.parse(map['timestamp'] as String),
      placeholder:map['placeholder']?? '');

  LocationModel copyWith({
    double? latitude,
    double? longitude,
    DateTime? timestamp,
    String? placeholder,
  }) {
    return LocationModel(
      latitude: latitude ?? 15,
      longitude: longitude ?? 75,
      timestamp: timestamp ?? DateTime.now(),
      placeholder: placeholder ?? '',
    );
  }
}
