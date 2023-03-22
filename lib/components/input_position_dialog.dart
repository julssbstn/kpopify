// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class InputPositionDialog extends StatefulWidget {
  const InputPositionDialog({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);

  final Function onSubmitted;

  @override
  _InputPositionDialogState createState() => _InputPositionDialogState();
}

class _InputPositionDialogState extends State<InputPositionDialog> {
  late String position;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Position'),
      content: TextField(
        onChanged: (value) {
          setState(() {
            position = value;
          });
        },
      ),
      actions: <Widget>[
        MaterialButton(
          color: Colors.green,
          textColor: Colors.white,
          child: const Text('Submit'),
          onPressed: () {
            widget.onSubmitted(position);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
