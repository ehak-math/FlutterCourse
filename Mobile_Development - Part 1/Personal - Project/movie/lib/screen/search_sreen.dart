import 'package:flutter/material.dart';
import 'package:movie/api/api_constants.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/widgets/search/search_field.dart';
import 'package:movie/widgets/search/search_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  bool _isLoading = false;
  List<Movie> _searchResults = [];
  String? _error;


  void _onSearchChanged(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchQuery = query;
        _searchResults = [];
        _error = null;
      });
      return;
    }
  print(_searchQuery);

    setState(() {
      _searchQuery = query;
      _isLoading = true;
      _error = null;
    });

    try {
      final results = await ApiConstants().searchMovies(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            children: [
              SearchField(onChanged: _onSearchChanged),
              const SizedBox(height: 10,),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_error != null)
                Center(child: Text(_error!))
              else
                Expanded(
                  child: SearchGridView(searchResults: _searchResults),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
