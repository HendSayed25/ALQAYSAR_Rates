import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/helper/language/language_helper.dart';
import '../home_user_screen/widgets/home_screen_app_bar.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/strings.dart';
import '../../../domain/entities/customer.dart';
import '../../cubit/customer_cubit.dart';
import '../../states/customer_state.dart';
import '../../common/customer_grid.dart';

class ShowAllForAdminScreen extends StatefulWidget {
  const ShowAllForAdminScreen({super.key});

  @override
  State<ShowAllForAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<ShowAllForAdminScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerCubit>().fetchCustomers();
  }

  Future<void> _onRefresh() async {
    context.read<CustomerCubit>().fetchCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(95.h), //height of appBar
        child: const HomeScreenAppBarWidget(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.backgroundColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<CustomerCubit, CustomerState>(
                builder: (context, state) {
                  if (state is CustomerLoading) {
                    return Skeletonizer(
                      enabled: true,
                      effect: ShimmerEffect(
                        baseColor: AppColors.primaryColor[1],
                        highlightColor: AppColors.primaryColor[0],
                      ),
                      child: RefreshIndicator(
                        onRefresh: _onRefresh,
                        color: AppColors.secondaryColor,
                        backgroundColor: AppColors.primaryColor[0],
                        displacement: 40.h,
                        child: CustomerGrid(
                          customers: List.generate(
                            6,
                            (index) => Customer(
                              id: index,
                              name: 'Loading...',
                              userId: 'Loading...',
                              uncooperative: 0,
                              poor: 0,
                              good: 0,
                              veryGood: 0,
                              excellent: 0,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (state is CustomerLoaded) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: AppColors.secondaryColor,
                      backgroundColor: AppColors.primaryColor[0],
                      displacement: 40.h,
                      child: CustomerGrid(customers: state.customers),
                    );
                  } else if (state is CustomerError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.red,
                          fontFamily: AppLanguages.getPrimaryFont(context),
                        ),
                        textDirection: AppLanguages.getCurrentTextDirection(context),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(AppStrings.noCustomersFound.tr(),
                      textDirection: AppLanguages.getCurrentTextDirection(context),
                      style: TextStyle(fontFamily: AppLanguages.getPrimaryFont(context),),),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
