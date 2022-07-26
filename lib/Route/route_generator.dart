import 'package:employee/screens/add_employe_screen.dart';
import 'package:employee/screens/edit_employe_screen.dart';
import 'package:employee/screens/home_emplyee.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/add_employe_screen':
        return MaterialPageRoute(builder: (_) => const AddEmployeeScreen());
      case '/edit_employe_screen':
        if (args is int) {
          return MaterialPageRoute(builder: (_) => EditEmployeeScreen(id: args));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: const Text("No Routes"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("Sorry No Route is found", style: TextStyle(color: Colors.white,fontSize: 100.0),)
        ),
      );
    });
  }
}

