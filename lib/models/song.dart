class Song {
  String? title;
  num? streams;
  String? album;

  Song({
    this.title,
    this.streams,
    this.album,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      title: json["title"],
      streams: json["streams"],
      album: json["album"],
    );
  }

  Map toJson() {
    Map map = {
      "title": title,
      "streams": streams,
      "album": album,
    };
    return map;
  }
}
