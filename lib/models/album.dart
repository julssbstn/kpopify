class Album {
  String? title;
  num? year;

  Album({
    this.title,
    this.year,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      title: json["title"],
      year: json["year"],
    );
  }

  Map toJson() {
    Map map = {
      "title": title,
      "year": year,
    };
    return map;
  }
}
