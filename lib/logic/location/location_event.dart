part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

class ViewPosition extends LocationEvent {}

class FetchCurrentPosition extends LocationEvent {}

class ExportPostion extends LocationEvent {}

class AddPosition extends LocationEvent {}

class DeletePosition extends LocationEvent {
  final double latitude, longitude;

  DeletePosition({required this.latitude, required this.longitude});
}

class SelectPosition extends LocationEvent {
  final String placeholder;

  SelectPosition({required this.placeholder});
}
