// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class InputGroupDialog extends StatefulWidget {
  const InputGroupDialog({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);

  final Function onSubmitted;

  @override
  _InputGroupDialogState createState() => _InputGroupDialogState();
}

class _InputGroupDialogState extends State<InputGroupDialog> {
  late String group;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Group'),
      content: TextField(
        onChanged: (value) {
          setState(() {
            group = value;
          });
        },
      ),
      actions: <Widget>[
        MaterialButton(
          color: Colors.green,
          textColor: Colors.white,
          child: const Text('Submit'),
          onPressed: () {
            widget.onSubmitted(group);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
