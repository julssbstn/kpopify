// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:kpopify/models/album.dart';

class InputAlbumDialog extends StatefulWidget {
  const InputAlbumDialog({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);

  final Function onSubmitted;

  @override
  _InputAlbumDialogState createState() => _InputAlbumDialogState();
}

class _InputAlbumDialogState extends State<InputAlbumDialog> {
  late TextEditingController titleController;
  late TextEditingController yearController;
  late Album album;
  @override
  void initState() {
    titleController = TextEditingController();
    yearController = TextEditingController();
    album = Album();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Album'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Title: "),
          const SizedBox(height: 4),
          SizedBox(
            height: 40,
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text("Year: "),
          const SizedBox(height: 4),
          SizedBox(
            height: 40,
            child: TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        MaterialButton(
          color: Colors.green,
          textColor: Colors.white,
          child: const Text('Submit'),
          onPressed: () {
            if (yearController.text.isNotEmpty &&
                titleController.text.isNotEmpty) {
              setState(() {
                album.title = titleController.text;
                album.year = int.parse(yearController.text);
              });
              widget.onSubmitted(album);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
