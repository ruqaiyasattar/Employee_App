

import 'package:employee/local/db/app_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StreamEmployeeScreen extends StatefulWidget {
  const StreamEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<StreamEmployeeScreen> createState() => _StreamEmployeeScreen();
}

class _StreamEmployeeScreen extends State<StreamEmployeeScreen> {

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee Stream'),centerTitle: true,),
      body: StreamBuilder<List<EmployeeData>>(
        stream: Provider.of<AppDb>(context).getEmployeeStream(),
        builder: (context, snapshot) {
          final List<EmployeeData>? employees = snapshot.data;

          if (snapshot.connectionState != ConnectionState.done){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()),);
          }

          if (employees != null) {
            return ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context,index){

              final employee = employees[index];
              return GestureDetector(
                onTap: ()=>{ Navigator.pushNamed(context, '/edit_employe_screen', arguments: employee.id)},
                child: Card(
                  color: Colors.grey.shade200,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.green,
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      bottomRight: Radius.circular(32.0),
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(employee.id.toString(),style: const TextStyle(color: Colors.black),),
                        Text(employee.firstName.toString(),style: const TextStyle(color: Colors.black),),
                        Text(employee.lastName.toString(),style: const TextStyle(color: Colors.black),),
                        Text(employee.dateOfBirth.toIso8601String(),style: const TextStyle(color: Colors.black),),
                      ],
                    ),
                  ),
                ),
              );
            });
          }

          return const Text('No Data Found');
        },
      ),
      //not needed here
      /*floatingActionButton: FloatingActionButton.extended(
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
      ),*/
    );
  }
}
