import 'package:flutter/material.dart';
import 'package:peliculas/provider/movi_provider.dart';
import 'screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp( AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:( _ )=> MoviesProvider(),lazy: false, )
      ],
      child: MyApp(),
    );
  }
}  

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'datails': (_) => DatailsScreen(),
      },
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 125, 30, 142),
      )),
    );
  }
}
