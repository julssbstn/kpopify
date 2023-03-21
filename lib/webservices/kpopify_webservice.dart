import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kpopify/models/artist.dart';
import 'package:kpopify/models/artists.dart';

class KpopifyWebService {
  var client;
  var key;
  KpopifyWebService(String this.key) {
    this.client = client ?? http.Client();
  }

  Future<Artist> addArtist(
    Artist artist, {
    http.Client? client,
  }) async {
    try {
      final httpClient = client ?? http.Client();
      final url = "https://crudcrud.com/api/$key/kpopify";

      var body = jsonEncode(artist.toJson());

      var response = await httpClient.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(response.body) as Map<String, dynamic>;
        Artist result = Artist.fromJson(responseBody);
        return result;
      } else {
        throw Exception("failed to create Artist");
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<Artists> getArtistList({
    http.Client? client,
  }) async {
    try {
      final httpClient = client ?? http.Client();
      final url = "https://crudcrud.com/api/$key/kpopify";

      var response = await httpClient.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body) as List<dynamic>;
        Map<String, dynamic> artists = {"artists": result};
        Artists list = Artists.fromJson(artists);
        return list;
      } else {
        throw Exception("failed to fetch Artists");
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<Artist> getArtistProfile(
    String id, {
    http.Client? client,
  }) async {
    try {
      final httpClient = client ?? http.Client();
      final url = "https://crudcrud.com/api/$key/kpopify/$id";

      var response = await httpClient.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(response.body) as Map<String, dynamic>;
        Artist result = Artist.fromJson(responseBody);
        return result;
      } else {
        throw Exception("failed to fetch Artist Profile");
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<Artist> updateArtistProfile(
    String id,
    Artist artist, {
    http.Client? client,
  }) async {
    try {
      final httpClient = client ?? http.Client();
      final url = "https://crudcrud.com/api/$key/kpopify/$id";

      var body = jsonEncode(artist.toJson());

      var response = await httpClient.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(response.body) as Map<String, dynamic>;
        Artist result = Artist.fromJson(responseBody);
        return result;
      } else {
        throw Exception("failed to update Artist");
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<bool> deleteArtist(
    String? id, {
    http.Client? client,
  }) async {
    try {
      if (id == null) throw Exception("empty id");

      final httpClient = client ?? http.Client();
      final url = "https://crudcrud.com/api/$key/kpopify/$id";

      var response = await httpClient.delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("failed to delete Artist");
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
