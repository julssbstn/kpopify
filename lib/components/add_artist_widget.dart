// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kpopify/components/input_album_dialog.dart';
import 'package:kpopify/components/input_group_dialog.dart';
import 'package:kpopify/components/input_position_dialog.dart';
import 'package:kpopify/components/input_song_dialog.dart';
import 'package:kpopify/models/album.dart';
import 'package:kpopify/models/artist.dart';
import 'package:intl/intl.dart';
import 'package:kpopify/models/song.dart';

class AddArtistWidget extends StatefulWidget {
  const AddArtistWidget({
    Key? key,
    required this.addArtist,
  }) : super(key: key);

  final Future Function(Artist artist) addArtist;

  @override
  _AddArtistWidgetState createState() => _AddArtistWidgetState();
}

class _AddArtistWidgetState extends State<AddArtistWidget> {
  late TextEditingController stageNameController;
  late TextEditingController listenersController;
  late TextEditingController realNameController;
  late TextEditingController birthdayController;
  late TextEditingController ageController;
  late TextEditingController companyController;
  late TextEditingController backgroundController;

  List<String> positions = [];
  List<String> groups = [];
  List<Album> albums = [];
  List<Song> songs = [];

  late Artist artist;

  @override
  void initState() {
    artist = Artist();
    stageNameController = TextEditingController();
    listenersController = TextEditingController();
    realNameController = TextEditingController();
    birthdayController = TextEditingController();
    ageController = TextEditingController();
    companyController = TextEditingController();
    backgroundController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    stageNameController.dispose();
    listenersController.dispose();
    realNameController.dispose();
    birthdayController.dispose();
    ageController.dispose();
    companyController.dispose();
    backgroundController.dispose();
    super.dispose();
  }

  bool _validation() {
    return stageNameController.text.isNotEmpty &&
        listenersController.text.isNotEmpty &&
        realNameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        birthdayController.text.isNotEmpty &&
        companyController.text.isNotEmpty &&
        backgroundController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          const Expanded(child: Text('Add Artist')),
          TextButton(
              onPressed: _validation()
                  ? () {
                      setState(() {
                        artist.stageName = stageNameController.text;
                        artist.listeners = int.parse(listenersController.text);
                        artist.name = realNameController.text;
                        artist.age = int.parse(ageController.text);
                        artist.birthday = birthdayController.text;
                        artist.company = companyController.text;
                        artist.background = backgroundController.text;
                        artist.groups = groups;
                        artist.position = positions;
                        artist.albums = albums;
                        artist.songs = songs;

                        widget.addArtist(artist);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              style: TextButton.styleFrom(
                backgroundColor: _validation() ? Colors.green : Colors.grey,
                foregroundColor: Colors.white,
              ),
              child: const Text("ADD")),
        ],
      )),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              _buildHeaderInfo(),
              _buildAbout(),
              _buildAlbums(),
              _buildSongs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    // var formatter = NumberFormat('#,###,000');
    // final listeners = formatter.format(widget.details!.listeners);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(label: "Stage Name: ", controller: stageNameController),
        _buildTextField(
          label: "Monthly Listeners: ",
          controller: listenersController,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildTextField({
    String? label,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? ""),
        const SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: TextField(
            keyboardType: keyboardType,
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildSongs() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "RELEASES",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          _buildListSong(
            "Add Songs: ",
            songs,
            InputSongDialog(
              onSubmitted: (Song song) {
                setState(() {
                  songs.add(song);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlbums() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "ABLUMS",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          _buildListAlbum(
            "Add Albums: ",
            albums,
            InputAlbumDialog(
              onSubmitted: (Album album) {
                setState(() {
                  albums.add(album);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbout() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "ABOUT",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          _buildTextField(label: "Real Name:", controller: realNameController),
          _buildTextField(label: "Birthday:", controller: birthdayController),
          _buildTextField(
            label: "Age:",
            controller: ageController,
            keyboardType: TextInputType.number,
          ),
          _buildTextField(label: "Company:", controller: companyController),
          _buildBackgroundField(backgroundController),
          _buildListString(
            "Groups: ",
            groups,
            InputGroupDialog(
              onSubmitted: (String group) {
                setState(() {
                  groups.add(group);
                });
              },
            ),
          ),
          _buildListString(
            "Positions: ",
            positions,
            InputPositionDialog(
              onSubmitted: (String position) {
                setState(() {
                  positions.add(position);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListAlbum(String label, List<Album> list, Widget dialog) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            InkWell(
              onTap: () {
                _showInputDialog(context, dialog);
              },
              child: const Icon(
                Icons.add_circle_outline,
                size: 32,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        _displayListAlbum(list),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildListSong(String label, List<Song> list, Widget dialog) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            InkWell(
              onTap: () {
                _showInputDialog(context, dialog);
              },
              child: const Icon(
                Icons.add_circle_outline,
                size: 32,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        _displayListSong(list),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildListString(String label, List<String> list, Widget dialog) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            InkWell(
              onTap: () {
                _showInputDialog(context, dialog);
              },
              child: const Icon(
                Icons.add_circle_outline,
                size: 32,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        _displayList(list),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _displayList(List<String> stringList) {
    List<Widget> list = stringList.map((e) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: Text(e)),
          InkWell(
            onTap: () {
              setState(() {
                stringList.removeWhere((p) => p == e);
              });
            },
            child: const Icon(
              Icons.delete,
              size: 24,
              color: Colors.red,
            ),
          ),
        ],
      );
    }).toList();

    return Column(
      children: list,
    );
  }

  Widget _displayListSong(List<Song> songList) {
    List<Widget> list = songList.map((e) {
      var formatter = NumberFormat('#,###,000');
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${e.title} from ${e.album}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${formatter.format(e.streams)} streams",
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ],
          )),
          InkWell(
            onTap: () {
              setState(() {
                songList.removeWhere((p) => p.title == e.title);
              });
            },
            child: const Icon(
              Icons.delete,
              size: 24,
              color: Colors.red,
            ),
          ),
        ],
      );
    }).toList();

    return Column(
      children: list,
    );
  }

  Widget _displayListAlbum(List<Album> albumList) {
    List<Widget> list = albumList.map((e) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${e.title}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${e.year}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ],
          )),
          InkWell(
            onTap: () {
              setState(() {
                albumList.removeWhere((p) => p.title == e.title);
              });
            },
            child: const Icon(
              Icons.delete,
              size: 24,
              color: Colors.red,
            ),
          ),
        ],
      );
    }).toList();

    return Column(
      children: list,
    );
  }

  Future<void> _showInputDialog(BuildContext context, Widget dialog) async {
    return showDialog(
      context: context,
      builder: (context) {
        return dialog;
      },
    );
  }

  Widget _buildBackgroundField(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Background: "),
        const SizedBox(height: 4),
        SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            controller: controller,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            maxLines: 100,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
