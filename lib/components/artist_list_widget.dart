// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:kpopify/models/artist.dart';
import 'package:kpopify/models/artists.dart';

class ArtistListWidget extends StatefulWidget {
  const ArtistListWidget({
    Key? key,
    required this.getArtistList,
    required this.deleteArtist,
    required this.stream,
  }) : super(key: key);

  final Future Function() getArtistList;
  final Future<bool> Function(String? id) deleteArtist;
  final Stream<Artists> stream;

  @override
  _ArtistListWidgetState createState() => _ArtistListWidgetState();
}

class _ArtistListWidgetState extends State<ArtistListWidget> {
  List<Artist> _artists = [];

  @override
  void initState() {
    super.initState();
    widget.getArtistList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<Artists>(
        stream: widget.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final results = snapshot.data as Artists;
            _artists = results.artists;

            return _buildList(_artists);
          } else {
            return Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  'Loading ...',
                  key: Key("LoadingWidget"),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildList(List<Artist> list) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () async {
            // final details = await widget.getProductDetail(list[index].id);
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => ProductDetailsWidget(
            //       details: details,
            //     ),
            //   ),
            // );
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              tileColor: Colors.grey[300],
              contentPadding: const EdgeInsets.all(8),
              leading: const SizedBox(
                height: 50.0,
                width: 50.0,
                child: Icon(Icons.face_6, size: 48),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${list[index].stageName}"),
                  const SizedBox(height: 8),
                  Text(
                    "${list[index].listeners} monthly listeners",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      final artist = list[index];
                      final success = await widget.deleteArtist(artist.id);

                      if (success) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              '${artist.stageName} has been successfully deleted',
                            ),
                          ));
                        }

                        await widget.getArtistList();
                      }
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${list[index].groups?.first}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "${list[index].position?.first}",
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
