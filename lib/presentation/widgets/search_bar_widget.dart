import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final void Function(String searchQuery) onSearch;
  const SearchBarWidget({super.key, required this.onSearch});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  String searchQuery = "";
  final _searchController = TextEditingController();

  onSearch() {
    searchQuery = _searchController.text;
    widget.onSearch(searchQuery);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Color.fromRGBO(103, 104, 109, 1)),
        filled: true,
        contentPadding: EdgeInsets.only(
          left: 24,
          top: 10,
          bottom: 10,
          right: 17,
        ),
        fillColor: Color.fromRGBO(58, 63, 71, 1),
        suffixIcon: IconButton(
          onPressed: onSearch,
          icon: Icon(
            Icons.search,
            color: Color.fromRGBO(103, 104, 109, 1),
          ),
        ),
        hintText: 'Search',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0))),
      ),
    );
  }
}
