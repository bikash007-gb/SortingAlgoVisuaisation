import 'package:flutter/material.dart';
import './home.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(
    new MaterialApp(
      title: 'Sorting',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Colors.green[300],
        brightness: Brightness.dark,
      ),
      home: Newhome(),
    )
  );
}