import 'package:find_locate/data/model/location_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
    required this.listPoint,
    required this.selectedPosition,
  });

  final List<LocationModel> listPoint;
  final String selectedPosition;

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = Set.from(listPoint.map(
      (location) {
        bool isActive = selectedPosition == location.placeholder;
        return Marker(
            markerId: MarkerId('marker:${location.placeholder}'),
            position: LatLng(location.latitude, location.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(isActive ? 0 : 50));
      },
    ));
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: (listPoint.isNotEmpty)
            ? LatLng(listPoint.last.latitude, listPoint.last.longitude)
            : const LatLng(11, 75.90),
        zoom: 10,
      ),
      markers: markers,
      polylines: {
        Polyline(
          width: 3,
          color: Colors.redAccent,
          polylineId: const PolylineId('connect'),
          points: listPoint
              .map((postion) => LatLng(postion.latitude, postion.longitude))
              .toList(),
        )
      },
    );
  }
}
