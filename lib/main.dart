import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News app',
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: const ColorScheme(
          background: Color.fromRGBO(230,230,230,1),
          onBackground: Colors.black,
          primary: Colors.white,
          onPrimary: Colors.black,
          secondary: Colors.black,
          onSecondary: Colors.white,
          brightness: Brightness.light,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        textTheme:const TextTheme(
          headlineMedium:TextStyle(
            fontWeight:FontWeight.bold,
            fontSize:21.0,
            fontFamily:'Serif',
          ),
          headlineSmall:TextStyle(
            fontWeight:FontWeight.bold,
            fontSize:19.0,
            fontFamily:'Serif',
          ),
          bodyMedium:TextStyle(
            fontSize:16.0,
          ),
        ),
      ),
      home: const Home(),
    );
  }
}