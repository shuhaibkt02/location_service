import 'package:find_locate/logic/location/location_bloc.dart';
import 'package:find_locate/presentation/widget/home/bottomsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
              onPressed: () => context.read<LocationBloc>().add(AddPosition()),
              child: const Icon(Icons.add)),
          FloatingActionButton.extended(
              onPressed: () {
                context.read<LocationBloc>().add(ViewPosition());
                showModalBottomSheet(
                    context: context,
                    builder: (context) => const BottomSheetWidget());
              },
              label: const Text('history')),
        ],
      ),
    );
  }
}
