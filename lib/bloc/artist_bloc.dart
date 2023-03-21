import 'dart:async';

import 'package:kpopify/bloc/bloc_provider.dart';
import 'package:kpopify/models/artist.dart';
import 'package:kpopify/models/artists.dart';
import 'package:kpopify/webservices/kpopify_webservice.dart';

class ArtistBloc implements Bloc {
  KpopifyWebService? _service;
  var key;

  ArtistBloc(String this.key, {KpopifyWebService? service}) {
    _service = service ?? KpopifyWebService(key);
  }

  Artists? _artists;

  final _artistListController = StreamController<Artists>();
  Stream<Artists> get artistListStream => _artistListController.stream;

  Future<void> searchArtist(String? search) async {
    if (search == null) return;
    if (_artists == null) await getArtistList();

    final filteredList = _artists?.artists.where((e) {
      if (e.stageName == null ||
          e.name == null ||
          e.listeners == null ||
          e.groups == null ||
          e.position == null) return false;

      final searchByStageName =
          e.stageName?.toLowerCase().contains(search.toLowerCase()) ?? false;
      final searchByName =
          e.name?.toLowerCase().contains(search.toLowerCase()) ?? false;
      final searchByListeners =
          e.listeners?.toString().contains(search.toLowerCase()) ?? false;
      final searchByGroups =
          e.groups?.any((e) => e.contains(search.toLowerCase())) ?? false;
      final searchByPosition =
          e.position?.any((e) => e.contains(search.toLowerCase())) ?? false;

      return searchByStageName ||
          searchByName ||
          searchByListeners ||
          searchByGroups ||
          searchByPosition;
    }).toList();

    if (filteredList != null) {
      _artistListController.sink.add(Artists(artists: filteredList));
    }
  }

  Future<void> sortArtist(bool active) async {
    if (active) {
      final list = List<Artist>.from(_artists!.artists);
      list.sort((a, b) {
        return a.stageName!.toLowerCase().compareTo(b.stageName!.toLowerCase());
      });
      _artistListController.sink.add(Artists(artists: list));
    } else {
      final list = Artists(artists: _artists!.artists);
      _artistListController.sink.add(list);
    }
  }

  Future<void> getArtistList() async {
    try {
      final service = _service ?? KpopifyWebService(key);

      Artists artists = await service.getArtistList();
      _artists = artists;
      _artistListController.sink.add(artists);
    } catch (e) {
      _artistListController.sink.addError(e);
    }
  }

  Future<Artist> getArtistProfile(String id) async {
    try {
      final service = _service ?? KpopifyWebService(key);

      Artist profile = await service.getArtistProfile(id);
      return profile;
    } catch (e) {
      throw e;
    }
  }

  Future<Artist> addArtist(Artist artist) async {
    try {
      final service = _service ?? KpopifyWebService(key);

      Artist profile = await service.addArtist(artist);
      return profile;
    } catch (e) {
      throw e;
    }
  }

  Future<Artist> updateArtistProfile(String id, Artist artist) async {
    try {
      final service = _service ?? KpopifyWebService(key);

      Artist profile = await service.updateArtistProfile(id, artist);
      return profile;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> deleteArtist(String? id) async {
    try {
      final service = _service ?? KpopifyWebService(key);

      bool success = await service.deleteArtist(id);
      return success;
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _artistListController.close();
  }
}
