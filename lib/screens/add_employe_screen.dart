import 'package:employee/local/db/app_db.dart';
import 'package:employee/widget/custom_date_picker_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;
import 'package:provider/provider.dart';

import '../widget/custom_text_form_feild.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime ? _dateofBirth;

  @override
  void initState() {


    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Employee"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){addEmployee();}, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFieldWidget(controller: _userNameController, txtlable: "User Name"),
                  const SizedBox(height: 8.0),
                  CustomTextFieldWidget(controller: _firstNameController, txtlable: "First Name"),
                  const SizedBox(height: 8.0),
                  CustomTextFieldWidget(controller: _lastNameController, txtlable: "Last Name"),
                  const SizedBox(height: 8.0),
                  CustomDatePickerFormField(controller: _dobController, txtlabel: 'Date Of Birth', callback: ()=>{dateTimePicker(context)}),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> dateTimePicker(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _dateofBirth ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) => Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.pink,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? const Text("")
      ),
    );
    if(newDate == null){
      return ;
    }
    setState((){
      _dateofBirth = newDate;
      String dob = DateFormat('dd/MM/yyyy').format(newDate);
      _dobController.text = dob;
    });
  }

  void addEmployee(){
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {

      final entity = EmployeeCompanion(
        userName: drift.Value(_userNameController.text),
        firstName: drift.Value(_firstNameController.text),
        lastName: drift.Value(_lastNameController.text),
        dateOfBirth: drift.Value(_dateofBirth!),
      );
      Provider.of<AppDb>(context, listen: false).insertEmployee(entity).then((value) => ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
              backgroundColor: Colors.pink,
              content: Text('New Employee Inserted: $value',style: const TextStyle(color: Colors.white),),
              actions: [
                TextButton(
                    onPressed: ()=>{ ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),},
                    child: const Text('Close',style: TextStyle(color: Colors.white),))
              ]
          )
      ),
      );
    }
  }
}
