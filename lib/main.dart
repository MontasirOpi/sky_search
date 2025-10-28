import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_bloc.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_event.dart';
import 'package:sky_search/screens/searchScreen/search_screen.dart';

void main() {
  runApp(const SkySearchApp());
}

class SkySearchApp extends StatelessWidget {
  const SkySearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FlightSearchBloc()..add(LoadAirports()),
      child: MaterialApp(
        title: 'SkySearch',
        debugShowCheckedModeBanner: false,

        home: const FlightSearchScreen(),
      ),
    );
  }
}
