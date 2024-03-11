import 'package:find_locate/data/provider/location_db.dart';
import 'package:find_locate/data/repo/location_repo.dart';
import 'package:find_locate/logic/location/location_bloc.dart';
import 'package:find_locate/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationBloc(
            locationRepository: SQLiteLocationRepository(
              database: LocationDB().database,
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Location tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
