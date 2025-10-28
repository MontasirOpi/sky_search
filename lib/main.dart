import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_bloc.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_event.dart';
import 'package:sky_search/screens/searchScreen/search_screen.dart';

void main() {
  runApp(const SkySearchApp());
}

class SkySearchApp extends StatelessWidget {
  const SkySearchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FlightSearchBloc()..add(LoadAirports()),
      child: MaterialApp(
        title: 'SkySearch',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0047AB)),
          primaryColor: const Color(0xFF0047AB),
          scaffoldBackgroundColor: const Color(0xFFF5F7FA),
          fontFamily: 'Roboto',
          useMaterial3: true,
        ),
        home: const FlightSearchScreen(),
      ),
    );
  }
}
