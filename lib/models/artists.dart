import 'package:kpopify/models/artist.dart';

class Artists {
  List<Artist> artists;

  Artists({required this.artists});

  factory Artists.fromJson(Map<String, dynamic> json) {
    List<Artist> _artists = [];
    if (json['artists'] != null) {
      final list = json['artists'] as List;
      for (var e in list) {
        _artists.add(Artist.fromJson(e));
      }
    }

    return Artists(artists: _artists);
  }
}
