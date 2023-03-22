// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kpopify/components/edit_artist_widget.dart';
import 'package:kpopify/components/view_profile_widget.dart';
import 'package:kpopify/models/artist.dart';
import 'package:intl/intl.dart';

class ArtistProfileWidget extends StatefulWidget {
  const ArtistProfileWidget({
    Key? key,
    @required this.details,
    required this.updateArtist,
  }) : super(key: key);

  final Artist? details;
  final Future Function(String? id, Artist artist) updateArtist;

  @override
  _ArtistProfileWidgetState createState() => _ArtistProfileWidgetState();
}

class _ArtistProfileWidgetState extends State<ArtistProfileWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(child: Text('Artist Profile')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditArtistWidget(
                        artist: widget.details,
                        id: widget.details!.id,
                        updateArtist: widget.updateArtist,
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text("EDIT")),
          ],
        ),
      ),
      body: ViewProfileWidget(
        details: widget.details,
      ),
    );
  }
}
