import 'package:alqaysar_rates/features/ui/common/user_card_design_in_search.dart';
import 'package:flutter/material.dart';

import '../../../core/resource/colors_manager.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  final List<Map<String, dynamic>> _allUsers = [
    {'userName': 'Hend', 'rating': 4.5, 'showRating': true},
    {'userName': 'Ahmed', 'rating': 4.5, 'showRating': true},
    {'userName': 'Asmaa', 'rating': 4.0, 'showRating': true},
    {'userName': 'Alaa', 'rating': 3.0, 'showRating': true},
    ];
  List<Map<String,dynamic>> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _filteredUsers = _allUsers;
  }

  void _filterSearchResults(String query) {
    List<Map<String, dynamic>> results = [];
    if (query.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) => user['userName']
          .toLowerCase()
          .contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      _filteredUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: _filterSearchResults,
        )
            : const Text('ALQAYSAR'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.clear : Icons.search,color: Colors.white,),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear();
                  _filteredUsers = _allUsers;
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors:  AppColors.backgroundColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors:  AppColors.backgroundColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: _filteredUsers.length,
          itemBuilder: (context, index) {
            var user = _filteredUsers[index];
            return UserCardInSearch(
              userName: user['userName'],
              rating: user['rating'],
              showRating: user['showRating'],
            );
          },
        ),
      ),
    );
  }
}

