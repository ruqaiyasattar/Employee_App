import 'package:flutter/material.dart';

class CustomDatePickerFormField extends StatelessWidget {
  final TextEditingController _controller;
  final String _txtlabel;
  final VoidCallback _callback;
  const CustomDatePickerFormField({
    Key ? key,
    required TextEditingController controller,
    required String txtlabel,
    required VoidCallback callback
  }) : _controller = controller, _callback = callback, _txtlabel = txtlabel, super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(_txtlabel),
      ),
      validator: (value){
        if(value == null||value.isEmpty){
          return "$_txtlabel can not be empty";
        }
        return null;
      },
      onTap: _callback,
    );
  }
}
