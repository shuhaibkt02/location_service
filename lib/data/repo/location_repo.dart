import 'package:find_locate/data/model/location_model.dart';
import 'package:find_locate/data/provider/location_db.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sqflite/sqflite.dart';

@immutable
abstract class LocationRepository {
  Future<void> addPosition(
      {required LocationModel location,
      required List<LocationModel> cacheList});
  Future<void> deletePosition(
      {required double latitude, required double longitude});
  Future<List<LocationModel>> viewPosition();
  Future<LocationModel> getCurrentLocation();
}

class SQLiteLocationRepository implements LocationRepository {
  final Future<Database?> database;

  SQLiteLocationRepository({required this.database});

  @override
  Future<void> addPosition({
    required LocationModel location,
    required List<LocationModel> cacheList,
  }) async {
    final db = await database;
    if (db != null) {
      try {
        await db.insert(
          LocationDB().tableName,
          location.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      } catch (e) {
        throw Exception('Error inserting location: $e');
      }
    }
  }

  @override
  Future<void> deletePosition(
      {required double latitude, required double longitude}) async {
    final db = await database;
    if (db != null) {
      try {
        await db.delete(
          LocationDB().tableName,
          where: 'latitude = ? AND longitude = ?',
          whereArgs: [latitude, longitude],
        );
      } catch (e) {
        throw Exception('Error deleting location: $e');
      }
    }
  }

  @override
  Future<List<LocationModel>> viewPosition() async {
    final db = await database;
    List<LocationModel> locationList = [];
    if (db != null) {
      try {
        final List<Map<String, dynamic>> listOfPosition =
            await db.query(LocationDB().tableName);
        locationList = listOfPosition
            .map((position) => LocationModel.fromMap(position))
            .toList();
      } catch (e) {
        throw Exception('Error querying locations: $e');
      }
    }
    return locationList;
  }

  @override
  Future<LocationModel> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied");
      }
    }

    final currentPosition = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition.latitude, currentPosition.longitude);
    String placeName = '${placemarks.first.locality}';

    LocationModel fetchLocation = LocationModel(
      latitude: currentPosition.latitude,
      longitude: currentPosition.longitude,
      timestamp: DateTime.now(),
      placeholder: placeName,
    );
    return fetchLocation;
  }
}
