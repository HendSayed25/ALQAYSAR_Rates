import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/config/routes/route_constants.dart';
import '../../../../core/helper/data_intent.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/helper/language/language_helper.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/strings.dart';
import '../../../../service_locator.dart';
import '../../../data/local/app_prefs.dart';
import '../../common/user_card_design_in_search.dart';
import '../../cubit/customer_cubit.dart';
import '../../states/customer_state.dart';

class SearchScreen extends StatefulWidget {
  final int branch;
  const SearchScreen({super.key,required this.branch});

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
    context.read<CustomerCubit>().fetchCustomers(widget.branch);
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
          decoration: InputDecoration(
            hintText: AppStrings.searchByName.tr(),
            hintStyle: const TextStyle(color: Colors.black),
            border: InputBorder.none,
          ),
          style: TextStyle(
              color: Colors.white,),
          textDirection: AppLanguages.getCurrentTextDirection(context),
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
                      branch: "first branch",
                      rating: 0.0,
                    );
                  },
                ),
              );
            } else if (state is CustomerLoaded) {
              if (state.customers.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.noCustomersFound.tr(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        textDirection:
                            AppLanguages.getCurrentTextDirection(context),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: state.customers.length,
                  itemBuilder: (context, index) {
                    final customer = state.customers[index];
                    String branch=(customer.branch==1)?AppStrings.firstBranch.tr():AppStrings.secondBranch.tr();
                    return GestureDetector(
                      onTap: () {
                        DataIntent.pushCustomer(customer);
                        sl<AppPrefs>().getString("role") == "admin"
                            ? context.pushNamed(Routes.userOverviewScreenRoute)
                            : context.pushNamed(Routes.rateScreenUserRoute);
                      },
                      child: UserCardInSearch(
                        userName: customer.name,
                        branch: branch,
                        rating: 5,
                      ),
                    );
                  },
                );
              }
            } else if (state is CustomerError) {
              return Center(child: Text(state.message));
            } else {
              return Center(
                child: Text(
                  AppStrings.startTypingToSearch.tr(),
                  textDirection: AppLanguages.getCurrentTextDirection(context),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
