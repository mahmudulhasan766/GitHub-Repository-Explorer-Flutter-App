import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readback/core/constants/app_colors.dart';
import 'package:readback/core/constants/app_text_style.dart';
import 'package:readback/core/constants/theme_color.dart';
import 'package:readback/features/home/model/repository_list_model.dart';
import 'package:readback/features/theme/cubit/theme_cubit.dart';

class RepositoryCard extends StatefulWidget {
  final Items? items;
  final VoidCallback? onTap;

  const RepositoryCard({super.key, this.items, this.onTap});

  @override
  State<RepositoryCard> createState() => _RepositoryCardState();
}

class _RepositoryCardState extends State<RepositoryCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final theme = ThemeColor(state.themeMode);
        return InkWell(
          onTap: widget.onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: theme.cardColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.items?.fullName ?? "",
                        style: kBodyMediumSemibold.copyWith(
                            color: theme.textColor),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: theme.textColor,
                          size: 16.sp,
                        ),
                        4.horizontalSpace,
                        Text(
                          widget.items?.score.toString() ?? "",
                          style: kBodySmallRegular.copyWith(fontSize: 14.sp),
                        ),
                      ],
                    )
                  ],
                ),
                Text(widget.items?.owner?.login ?? ""),
                10.verticalSpace,
                Text(
                  widget.items?.description ?? "",
                  style: kBodySmallRegular,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
