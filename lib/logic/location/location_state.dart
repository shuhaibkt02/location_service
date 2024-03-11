part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationLoaded extends LocationState {
  final List<LocationModel> locationList;
  final String selectedPosition;

  LocationLoaded({
    required this.locationList,
    required this.selectedPosition,
  });
}

final class LocationError extends LocationState {
  final String errorMessage;

  LocationError({required this.errorMessage});
}
