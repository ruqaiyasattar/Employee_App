

import 'package:employee/local/db/app_db.dart';
import 'package:employee/screens/future_emplyee.dart';
import 'package:employee/screens/stream_emplyee.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int index = 0;
  late AppDb _db;
  final pages = const [
    FutureEmployeeScreen(),
    StreamEmployeeScreen(),
  ];
  @override
  void initState() {
    super.initState();
    _db = AppDb();
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Home'),centerTitle: true,),
      body: pages[index],
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.pushNamed(context, "/add_employe_screen");
            },
          icon:const Icon(Icons.add),label:const Text("Add Employee")
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value){
          setState((){
            index = value;
          });
        },
        backgroundColor: Colors.blue.shade300,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white30,
        showSelectedLabels: false,
        showUnselectedLabels: true,

        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              activeIcon: Icon(Icons.list_alt_outlined),
              label: 'Employee Future'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              activeIcon: Icon(Icons.list_alt_outlined),
              label: 'Employee Stream'
          ),

        ],
      ),
    );
  }
}
