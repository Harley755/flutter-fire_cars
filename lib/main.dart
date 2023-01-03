import 'package:fire_cars/routes.dart';
import 'package:fire_cars/services/authentification.dart';
import 'package:fire_cars/services/db_services.dart';
import 'package:fire_cars/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'model/carModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  await Firebase.initializeApp();
  setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        // FOR USER
        StreamProvider.value(
          initialData: [],
          value: AuthService().user,
        ),

        // FOR CAR
        StreamProvider<List<Car>>.value(
          initialData: [],
          value: DbServices().cars,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fire Cars',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      ),
      home: Wrapper(),
      onGenerateRoute: (settings) => Routes.generateRoute(settings),
      initialRoute: '/',
    );
  }
}
