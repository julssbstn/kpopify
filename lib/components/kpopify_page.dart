// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:kpopify/bloc/artist_bloc.dart';
import 'package:kpopify/bloc/bloc_provider.dart';
import 'package:kpopify/components/artist_list_widget.dart';
import 'package:kpopify/components/filter_widget.dart';
import 'package:kpopify/models/artist.dart';

class KpopifyPage extends StatefulWidget {
  const KpopifyPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _KpopifyPageState createState() => _KpopifyPageState();
}

class _KpopifyPageState extends State<KpopifyPage> {
  late ArtistBloc artistBloc;

  @override
  void initState() {
    super.initState();
    artistBloc = BlocProvider.of<ArtistBloc>(context);
  }

  Future<void> _handleGetArtistList() async {
    await artistBloc.getArtistList();
  }

  Future<bool> _handleDeleteArtist(String? id) async {
    return await artistBloc.deleteArtist(id);
  }

  Future<void> _handleSearchArtist(String? search) async {
    await artistBloc.searchArtist(search);
  }

  Future<void> _handleSortArtist(bool active) async {
    await artistBloc.sortArtist(active);
  }

  Future<void> _handleAddArtist(Artist artist) async {
    await artistBloc.addArtist(artist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("KpopifyPage"),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          FilterWidget(
            searchArtist: (search) => _handleSearchArtist(search),
            sortArtist: (active) => _handleSortArtist(active),
            addArtist: (artist) => _handleAddArtist(artist),
          ),
          ArtistListWidget(
            getArtistList: () => _handleGetArtistList(),
            deleteArtist: (id) => _handleDeleteArtist(id),
            stream: artistBloc.artistListStream,
          ),
        ],
      ),
    );
  }
}
