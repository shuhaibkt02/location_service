import 'package:find_locate/data/model/location_model.dart';
import 'package:find_locate/data/repo/location_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;
  List<LocationModel> cachePosition = [];

  String selectedPosition = '';
  LocationBloc({required this.locationRepository}) : super(LocationInitial()) {
    on<AddPosition>((event, emit) async {
      emit(LocationLoading());
      try {
        LocationModel currentLocation =
            await locationRepository.getCurrentLocation();

        await locationRepository.addPosition(
            location: currentLocation, cacheList: cachePosition);
        cachePosition = await locationRepository.viewPosition();

        emit(LocationLoaded(
            locationList: cachePosition, selectedPosition: selectedPosition));
      } catch (e) {
        emit(LocationError(errorMessage: 'error: $e'));
      }
    });

    on<DeletePosition>((event, emit) async {
      emit(LocationLoading());
      try {
        await locationRepository.deletePosition(
            latitude: event.latitude, longitude: event.longitude);
        cachePosition = await locationRepository.viewPosition();
        if (kDebugMode) {
          print(cachePosition.length);
        }
        emit(LocationLoaded(
            locationList: cachePosition, selectedPosition: selectedPosition));
      } catch (e) {
        emit(LocationError(errorMessage: 'error :$e'));
      }
    });
    on<ViewPosition>((event, emit) async {
      emit(LocationLoading());
      try {
        cachePosition = await locationRepository.viewPosition();
        emit(LocationLoaded(
            locationList: cachePosition, selectedPosition: selectedPosition));
      } catch (e) {
        emit(LocationError(errorMessage: 'error :$e'));
      }
    });

    on<SelectPosition>((event, emit) async {
      emit(LocationLoaded(
          locationList: cachePosition, selectedPosition: event.placeholder));
    });
  }
}
