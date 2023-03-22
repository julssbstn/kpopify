// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kpopify/models/artist.dart';
import 'package:intl/intl.dart';

class ViewProfileWidget extends StatefulWidget {
  const ViewProfileWidget({
    Key? key,
    @required this.details,
  }) : super(key: key);

  final Artist? details;

  @override
  _ViewProfileWidgetState createState() => _ViewProfileWidgetState();
}

class _ViewProfileWidgetState extends State<ViewProfileWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeaderInfo(),
            _buildGroups(),
            _buildSongs(),
            _buildAlbums(),
            _buildAbout(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    var formatter = NumberFormat('#,###,000');
    final listeners = formatter.format(widget.details!.listeners);
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.face_6,
                size: 48,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  "${widget.details!.stageName}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  "$listeners monthly listeners",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGroups() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "GROUPS",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(height: 60.0, enableInfiniteScroll: false),
            items: widget.details!.groups!.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(color: Colors.black12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.group,
                          color: Colors.blue,
                        ),
                        Text(i),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildSongs() {
    var formatter = NumberFormat('#,###,000');

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "POPULAR RELEASES",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.details!.songs!.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const Icon(
                  Icons.music_note,
                  size: 32,
                  color: Colors.black,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.details!.songs![index].title}",
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${formatter.format(widget.details!.songs![index].streams)} streams",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
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
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.details!.albums!.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const Icon(
                  Icons.album,
                  size: 32,
                  color: Colors.black,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.details!.albums![index].title}",
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${widget.details!.albums![index].year}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
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
          _buildAboutField("Real Name:", widget.details!.name),
          _buildAboutField("Birthday:", widget.details!.birthday),
          _buildAboutField("Age:", widget.details!.age.toString()),
          _buildAboutField("Company:", widget.details!.company),
          _buildAboutField("Positions:", widget.details!.position!.join(", ")),
          _buildBackgroundField(widget.details!.background),
        ],
      ),
    );
  }

  Widget _buildAboutField(String label, String? value) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            Text(value ?? ""),
          ],
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildBackgroundField(String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Background: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            readOnly: true,
            initialValue: value ?? "",
            maxLines: 100,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
