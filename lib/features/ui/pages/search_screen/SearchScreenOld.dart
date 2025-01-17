// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// import '../../../../core/resource/colors_manager.dart';
// import '../../common/user_card_design_in_search.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final List<Map<String, dynamic>> _allUsers = [
//     {'userName': 'Hend', 'rating': 4.5, 'showRating': true},
//     {'userName': 'Ahmed', 'rating': 4.5, 'showRating': true},
//     {'userName': 'Asmaa', 'rating': 4.0, 'showRating': true},
//     {'userName': 'Alaa', 'rating': 3.0, 'showRating': true},
//   ];
//   List<Map<String, dynamic>> _filteredUsers = [];
//   Timer? _debounce;
//
//   @override
//   void initState() {
//     super.initState();
//     _filteredUsers = _allUsers;
//   }
//
//   void _filterSearchResults(String query) {
//     if (_debounce?.isActive ?? false) _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 300), () {
//       setState(() {
//         _filteredUsers = query.isEmpty
//             ? _allUsers
//             : _allUsers.where((user) {
//           return user['userName']
//               .toLowerCase()
//               .contains(query.toLowerCase());
//         }).toList();
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _debounce?.cancel();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: TextField(
//           controller: _searchController,
//           autofocus: true,
//           decoration: const InputDecoration(
//             hintText: 'Search by name...',
//             border: InputBorder.none,
//           ),
//           onChanged: _filterSearchResults,
//         ),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: AppColors.backgroundColor,
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: AppColors.backgroundColor,
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: _filteredUsers.isEmpty
//             ? const Center(
//           child: Text(
//             'No users found',
//             style: TextStyle(fontSize: 18, color: Colors.white),
//           ),
//         )
//             : ListView.builder(
//           itemCount: _filteredUsers.length,
//           itemBuilder: (context, index) {
//             var user = _filteredUsers[index];
//             return UserCardInSearch(
//               userName: user['userName'],
//               rating: user['rating'],
//               showRating: user['showRating'],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
