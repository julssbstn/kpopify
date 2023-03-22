// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:kpopify/models/album.dart';
import 'package:kpopify/models/song.dart';

class InputSongDialog extends StatefulWidget {
  const InputSongDialog({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);

  final Function onSubmitted;

  @override
  _InputSongDialogState createState() => _InputSongDialogState();
}

class _InputSongDialogState extends State<InputSongDialog> {
  late TextEditingController titleController;
  late TextEditingController albumController;
  late TextEditingController streamController;
  late Song song;
  @override
  void initState() {
    titleController = TextEditingController();
    albumController = TextEditingController();
    streamController = TextEditingController();
    song = Song();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    albumController.dispose();
    streamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Song'),
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
          const Text("Album: "),
          const SizedBox(height: 4),
          SizedBox(
            height: 40,
            child: TextField(
              controller: albumController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text("Streams: "),
          const SizedBox(height: 4),
          SizedBox(
            height: 40,
            child: TextField(
              controller: streamController,
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
            if (albumController.text.isNotEmpty &&
                titleController.text.isNotEmpty &&
                streamController.text.isNotEmpty) {
              setState(() {
                song.title = titleController.text;
                song.album = albumController.text;
                song.streams = int.parse(streamController.text);
              });
              widget.onSubmitted(song);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
