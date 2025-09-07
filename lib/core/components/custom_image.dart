import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/assets.dart';
import '../constants/app_colors.dart';
import 'custom_svg.dart';

class CustomImage extends StatelessWidget {
  final double? width;
  final double? height;
  final double? size;
  final String? baseUrl;
  final String? placeHolder;
  final Color? bgColor;
  final BoxFit? fit;
  final double radius;
  final bool oneSideRadius;
  final bool innerShadow;
  final bool isCircle;

  const CustomImage({
    super.key,
    this.width,
    this.height,
    this.size,
    this.placeHolder,
    this.fit,
    this.baseUrl,
    this.radius = 0,
    this.oneSideRadius = false,
    this.innerShadow = false,
    this.isCircle = false,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return baseUrl != null || baseUrl != "null"
        ? Container(
            clipBehavior: Clip.antiAlias,
            width: isCircle ? size : width,
            height: isCircle ? size : height,
            decoration: isCircle
                ? const BoxDecoration(shape: BoxShape.circle)
                : BoxDecoration(
                    color: bgColor ?? AppColors.white,
                    borderRadius: oneSideRadius
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(radius),
                            topLeft: Radius.circular(radius),
                          )
                        : BorderRadius.circular(radius),
                    //
                    // shape: isCircle!?BoxShape.circle:null
                  ),
            child: CachedNetworkImage(
              imageUrl: baseUrl ?? '',
              fit: fit ?? BoxFit.cover,
              color: innerShadow ? Colors.black.withValues(alpha: .3) : null,
              colorBlendMode: innerShadow ? BlendMode.darken : null,
              placeholder: (context, url) => Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(
                      color: bgColor ?? AppColors.white,
                      borderRadius: BorderRadius.circular(radius),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(url),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Center(
                      child: SizedBox(
                        height: 24.r,
                        width: 24.r,
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  )
                ],
              ),
              errorWidget: (context, url, error) => isCircle
                  ? Container(
                      height: size,
                      width: size,
                      padding: EdgeInsets.all(5.r),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: bgColor ?? Colors.white),
                      child: CustomSvg(
                        icon: placeHolder ?? Assets.imagesPlaceholder,
                        fit: fit ?? BoxFit.fill,
                      ),
                    )
                  : CustomSvg(
                      icon: placeHolder ?? Assets.imagesPlaceholderImage,
                      fit: fit ?? BoxFit.fill,
                    ),
            ),
          )
        : Container(
            clipBehavior: Clip.antiAlias,
            width: isCircle ? size : width,
            height: isCircle ? size : height,
            decoration: isCircle
                ? const BoxDecoration(shape: BoxShape.circle)
                : BoxDecoration(
                    color: AppColors.gray900,
                    borderRadius: BorderRadius.circular(radius),
                  ),
            child: CustomSvg(
              icon: placeHolder ?? Assets.imagesPlaceholder,
              fit: fit ?? BoxFit.fill,
            ),
          );
  }
}
