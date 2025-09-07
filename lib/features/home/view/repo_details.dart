import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readback/core/app/app_context.dart';
import 'package:readback/core/constants/app_colors.dart';
import 'package:readback/core/constants/app_strings.dart';
import 'package:readback/core/constants/app_text_style.dart';
import 'package:readback/core/constants/theme_color.dart';
import 'package:readback/features/home/model/repository_list_model.dart';
import 'package:readback/features/theme/cubit/theme_cubit.dart';

class RepositoryDetailsPage extends StatelessWidget {
  final Items repository;

  const RepositoryDetailsPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.details.tr()),
            centerTitle: false,
            automaticallyImplyLeading: true,
            leading: GestureDetector(
              onTap: () => AppContext.back(),
              child: Icon(Icons.arrow_back_ios_new_outlined),
            ),
            actions: [
              Row(
                children: [
                  Text(AppStrings.darkMode.tr(), style: kBodyMedium),
                  CupertinoSwitch(
                    value: state.themeMode == ThemeModeStatus.dark,
                    onChanged: (bool val) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                ],
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(),
                const SizedBox(height: 24),
                _buildDescriptionSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                repository.fullName ?? 'No name',
                style: kBodyLarge,
              ),
            ),
            _buildStatsSection()
          ],
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final theme = ThemeColor(state.themeMode);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
              width: 1.sw,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(repository.owner?.avatarUrl ?? ''),
                    ),
                    5.verticalSpace,
                    Text(repository.name ?? ""),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        alignment: Alignment.center,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: FaIcon(
                              FontAwesomeIcons.github,
                              color: theme.headingFont,
                              size: 18.r,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          // Add spacing between icon and text
                          Flexible(
                            child: AutoSizeText(
                              repository.gitUrl ?? "",
                              textAlign: TextAlign.center,
                              style: kBodyMedium.copyWith(
                                color: theme.headingFont,
                                decoration: TextDecoration.underline,
                                decorationColor: theme.headingFont,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            16.verticalSpace,
            Text(
              repository.description ?? 'No description provided',
              style: kBodyRegularRegular.copyWith(color: AppColors.gray700),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Row(
        children: [
          _buildStatItem(Icons.star, '', repository.stargazersCount),
          6.horizontalSpace,
          _buildStatItem(Icons.call_split, 'Forks', repository.forksCount),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, dynamic value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16.sp),
        2.horizontalSpace,
        label.isNotEmpty
            ? Text(
                '$label: ${value ?? 'N/A'}',
                style: kBodyRegularMedium.copyWith(fontSize: 13.sp),
              )
            : Text(
                '${value ?? 'N/A'}',
                style: kBodyRegularMedium.copyWith(fontSize: 13.sp),
              ),
      ],
    );
  }
}
