// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:kpopify/models/album.dart';
import 'package:kpopify/models/song.dart';

class Artist {
  String? id;
  String? name;
  String? stageName;
  num? listeners;
  String? background;
  String? company;
  num? age;
  String? birthday;
  List<String>? groups;
  List<String>? position;
  List<Album>? albums;
  List<Song>? songs;

  Artist({
    this.id,
    this.name,
    this.stageName,
    this.listeners,
    this.background,
    this.company,
    this.age,
    this.birthday,
    this.groups,
    this.position,
    this.albums,
    this.songs,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    List<String> _groups = [];
    if (json['groups'] != null) {
      final list = json['groups'] as List;
      for (var e in list) {
        _groups.add(e);
      }
    }

    List<String> _position = [];
    if (json['position'] != null) {
      final list = json['position'] as List;
      for (var e in list) {
        _position.add(e);
      }
    }

    List<Album> _albums = [];
    if (json['albums'] != null) {
      final list = json['albums'] as List;
      for (var e in list) {
        _albums.add(Album.fromJson(e));
      }
    }

    List<Song> _songs = [];
    if (json['songs'] != null) {
      final list = json['songs'] as List;
      for (var e in list) {
        _songs.add(Song.fromJson(e));
      }
    }

    return Artist(
      id: json["_id"],
      name: json["name"],
      stageName: json["stageName"],
      listeners: json["listeners"],
      background: json["background"],
      company: json["company"],
      age: json["age"],
      birthday: json["birthday"],
      groups: _groups,
      position: _position,
      albums: _albums,
      songs: _songs,
    );
  }

  Map toJson() {
    final _albums = albums?.map((e) => e.toJson()).toList();
    final _songs = songs?.map((e) => e.toJson()).toList();

    Map map = {
      "name": name,
      "stageName": stageName,
      "listeners": listeners,
      "background": background,
      "company": company,
      "age": age,
      "birthday": birthday,
      "groups": groups,
      "position": position,
      "albums": _albums,
      "songs": _songs,
    };
    return map;
  }
}
