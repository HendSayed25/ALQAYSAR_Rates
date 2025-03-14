import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/helper/language/language_helper.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/strings.dart';
import '../../../domain/entities/customer_entity.dart';
import '../../cubit/customer_cubit.dart';
import '../../states/customer_state.dart';
import '../../common/customer_grid.dart';
import 'widgets/home_screen_app_bar.dart';

class ShowAllScreen extends StatefulWidget {
  final int branch;
  const ShowAllScreen({super.key, required this.branch});

  @override
  State<ShowAllScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<ShowAllScreen> {
  Future<void> _onRefresh() async {
    context.read<CustomerCubit>().fetchCustomers(widget.branch);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.h),
          child:  HomeScreenAppBarWidget(branch: widget.branch),
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
                              (index) => CustomerEntity(
                                id: index,
                                name: 'Loading...',
                                branch: 1
                              ),
                            ),
                            averageRate: null,
                          ),
                        ),
                      );
                    } else if (state is CustomerLoaded) {
                      return RefreshIndicator(
                        onRefresh: _onRefresh,
                        color: AppColors.secondaryColor,
                        backgroundColor: AppColors.primaryColor[0],
                        displacement: 40.h,
                        child: state.customers.isNotEmpty
                            ? CustomerGrid(
                          customers: state.customers,
                          averageRate: null,
                        )
                            : Center(
                          child: Text(
                            AppStrings.noCustomersFound.tr(),
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    } else if (state is CustomerError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.red,
                          ),
                          textDirection:
                              AppLanguages.getCurrentTextDirection(context),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          AppStrings.noCustomersFound.tr(),
                          textDirection:
                              AppLanguages.getCurrentTextDirection(context),
      
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
