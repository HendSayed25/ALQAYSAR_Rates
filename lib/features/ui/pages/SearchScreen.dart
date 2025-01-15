import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Sample list of users
  final List<String> users = [
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Bob Brown',
    'Charlie Davis',
  ];

  // List to store filtered users
  List<String> filteredUsers = [];

  // Controller for the TextField
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initially, show all users
    filteredUsers = users;
  }

  // Function to filter users based on the search query
  void filterUsers(String query) {
    setState(() {
      filteredUsers = users
          .where((user) => user.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search '),
        actions: [
          // Search icon
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Show the search bar when clicked
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  onSearch: filterUsers,
                  users: users,
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredUsers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredUsers[index]),
          );
        },
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final Function(String) onSearch;
  final List<String> users;

  CustomSearchDelegate({required this.onSearch, required this.users});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
          onSearch(query); // Update the user list
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search bar
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show the results based on the search query
    final results = users
        .where((user) => user.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions based on the query
    final suggestions = users
        .where((user) => user.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
        );
      },
    );
  }
}

