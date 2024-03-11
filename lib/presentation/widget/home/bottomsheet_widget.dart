import 'package:find_locate/data/model/location_model.dart';
import 'package:find_locate/logic/location/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<LocationModel> locationList =
        context.watch<LocationBloc>().cachePosition;
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context, index) {
          LocationModel locationData = locationList[index];

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
        itemCount: locationList.length,
      ),
    );
  }
}
