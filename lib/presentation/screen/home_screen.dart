import 'package:find_locate/data/model/location_model.dart';
import 'package:find_locate/logic/location/location_bloc.dart';
import 'package:find_locate/presentation/widget/home/floating_buttons.dart';
import 'package:find_locate/presentation/widget/home/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<LocationModel> sample = [];

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<LocationBloc, LocationState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is LocationInitial) {
            String selectedPosition =
                context.read<LocationBloc>().selectedPosition;
            return MapWidget(
                listPoint: const [], selectedPosition: selectedPosition);
          }

          if (state is LocationLoaded) {
            sample = state.locationList;
            return MapWidget(
                listPoint: state.locationList,
                selectedPosition: state.selectedPosition);
          }
          if (state is LocationError) {
            return Center(
              child: Text('error :${state.errorMessage}'),
            );
          }
          print('${sample.length} is sample');
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.redAccent,
            ),
          );
        },
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const CustomFloatingButton(),
    );
  }
}
