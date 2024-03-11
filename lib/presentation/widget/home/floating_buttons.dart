import 'package:find_locate/data/model/location_model.dart';
import 'package:find_locate/logic/location/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomFloatingButton extends StatelessWidget {
  // final List<LocationModel> locationList;
  const CustomFloatingButton({
    super.key,
    // required this.locationList,
  });

  @override
  Widget build(BuildContext context) {
    List<LocationModel> locationList =
        context.watch<LocationBloc>().cachePosition;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
              onPressed: () => context.read<LocationBloc>().add(AddPosition()),
              child: const Text('add')),
          FloatingActionButton(
              onPressed: () {
                context.read<LocationBloc>().add(ViewPosition());
                showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        _BottomSheetWidget(listPoint: locationList));
              },
              child: const Text('history')),
        ],
      ),
    );
  }
}

class _BottomSheetWidget extends StatelessWidget {
  const _BottomSheetWidget({required this.listPoint});

  final List<LocationModel> listPoint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context, index) {
          LocationModel locationData = listPoint[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.pin_drop),
              ),
              title: Text(locationData.placeholder),
              subtitle: Text(
                '${locationData.latitude} : ${locationData.longitude}',
              ),
              onTap: () {
                context
                    .read<LocationBloc>()
                    .add(SelectPosition(placeholder: locationData.placeholder));
              },
              trailing: IconButton(
                  onPressed: () {
                    context.read<LocationBloc>().add(DeletePosition(
                          latitude: locationData.latitude,
                          longitude: locationData.longitude,
                        ));
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
            ),
          );
        },
        itemCount: listPoint.length,
      ),
    );
  }
}
