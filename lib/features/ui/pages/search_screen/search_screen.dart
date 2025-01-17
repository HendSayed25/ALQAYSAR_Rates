import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../service_locator.dart';
import '../../../data/local/app_prefs.dart';
import '../../common/user_card_design_in_search.dart';
import '../../cubit/customer_cubit.dart';
import '../../states/customer_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Fetch customers when the screen loads
    context.read<CustomerCubit>().fetchCustomers();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<CustomerCubit>().filterCustomers(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search by name...',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: _onSearchChanged,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.backgroundColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.backgroundColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocBuilder<CustomerCubit, CustomerState>(
          builder: (context, state) {
            if (state is CustomerLoading) {
              return Skeletonizer(
                enabled: true,
                effect: ShimmerEffect(
                  baseColor: AppColors.primaryColor[1],
                  highlightColor: AppColors.primaryColor[0],
                ),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return UserCardInSearch(
                      userName: "userName",
                      rating: 0.0,
                      showRating: sl<AppPrefs>().getString("role") == "admin",
                    );
                  },
                ),
              );
            } else if (state is CustomerLoaded) {
              if (state.customers.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No customers found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: state.customers.length,
                  itemBuilder: (context, index) {
                    final customer = state.customers[index];
                    return UserCardInSearch(
                      userName: customer.name,
                      rating: customer.rating,
                      showRating: sl<AppPrefs>().getString("role") == "admin",
                    );
                  },
                );
              }
            } else if (state is CustomerError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Start typing to search...'));
            }
          },
        ),
      ),
    );
  }
}
