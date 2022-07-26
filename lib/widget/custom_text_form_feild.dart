
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    Key? key,
    required TextEditingController controller,
    required String txtlable,
  }) : _controller = controller,_txtlable = txtlable, super(key: key);

  final TextEditingController _controller;
  final String _txtlable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(_txtlable),
      ),
      validator: (value){
        if(value == null||value.isEmpty){
          return "$_txtlable can not be empty";
        }
        return null;
      },
    );
  }
}