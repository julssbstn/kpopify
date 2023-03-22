// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:kpopify/components/add_artist_widget.dart';
import 'package:kpopify/models/artist.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({
    Key? key,
    required this.searchArtist,
    required this.sortArtist,
    required this.addArtist,
  }) : super(key: key);

  final Future Function(String? search) searchArtist;
  final Future Function(bool active) sortArtist;
  final Future Function(Artist artist) addArtist;
  @override
  _FilterWidgettState createState() => _FilterWidgettState();
}

class _FilterWidgettState extends State<FilterWidget> {
  late TextEditingController searchController;
  late bool activeSort;
  @override
  void initState() {
    searchController = TextEditingController();
    activeSort = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: _buildSearch()),
          _buildSort(),
          _buildAdd(),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(4),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          suffixIcon: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                widget.searchArtist(searchController.text);
              },
              child: const Icon(Icons.search, size: 36)),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        onChanged: (value) {},
        onSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        onEditingComplete: () {},
      ),
    );
  }

  Widget _buildSort() {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          setState(() {
            activeSort = !activeSort;
            widget.sortArtist(activeSort);
          });
        },
        child: Icon(
          Icons.sort_by_alpha,
          size: 36,
          color: activeSort ? Colors.black : Colors.black45,
        ),
      ),
    );
  }

  Widget _buildAdd() {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          print("add");
          if (context.mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddArtistWidget(
                  addArtist: widget.addArtist,
                ),
              ),
            );
          }
        },
        child: const Icon(
          Icons.add,
          size: 36,
          color: Colors.green,
        ),
      ),
    );
  }
}
