import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readback/core/components/input_label.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_style.dart';
import '../../generated/assets.dart';
import 'custom_svg.dart';

class CustomTextField<T> extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.title,
    this.hint,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.onPress,
    this.errorText,
    this.prefixIconColor,
    this.suffixIconColor,
    this.fillColor,
    this.hintColor,
    this.onSaved,
    this.keyboardType,
    this.isEmail,
    this.borderThink,
    this.validator,
    this.prefixIconSize,
    this.suffixIconSizeWidth,
    this.suffixIconSizeHeight,
    this.onChanged,
    this.errorTextHeight,
    this.textColor,
    this.hintTextSize,
    this.height,
    this.width,
    this.radius,
    this.onTap,
    this.borderColor,
    this.isPassword = false,
    this.obscureText = false,
    this.readOnly = false,
    this.isDense = false,
    this.textInputAction = TextInputAction.next,
    this.errorStyle,
    this.underLineBorderColor,
    this.focusNode,
    this.isError = false,
    this.isRequired = true,
    this.hintStyle,
    this.titleStyle,
    this.onTapOutside,
    this.maxLines = 1,
  });

  final String? title;
  final String? hint;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onPress;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Color? textColor;
  final Color? fillColor;
  final Color? hintColor;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final String? errorText;
  final double? prefixIconSize;
  final double? suffixIconSizeWidth;
  final double? suffixIconSizeHeight;
  final double? errorTextHeight;
  final double? hintTextSize;
  final double? height;
  final double? width;
  final double? radius;
  final FormFieldSetter<T>? onSaved;
  final FormFieldValidator<T>? validator;
  final bool? isEmail;
  final bool isPassword;
  final bool obscureText;
  final bool readOnly;
  final bool isDense;
  final double? borderThink;
  final TextInputAction? textInputAction;
  final TextStyle? errorStyle;
  final Color? underLineBorderColor;
  final FocusNode? focusNode;
  final bool isError;
  final bool isRequired;
  final TextStyle? hintStyle;
  final TextStyle? titleStyle;
  final TapRegionCallback? onTapOutside;
  final int? maxLines;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(widget.radius ?? 16).r;

    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: widget.isError
            ? AppColors.error1
            : widget.borderColor ?? AppColors.white,
        width: widget.borderThink ?? 1.0,
      ),
      borderRadius: borderRadius.r,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          InputLabel(
            title: widget.title!,
            isRequired: widget.isRequired,
            textStyle: widget.titleStyle,
          ),
        TextFormField(
          readOnly: widget.readOnly,
          textAlign: TextAlign.start,
          obscureText: obscureText,
          cursorColor: AppColors.primary700,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscuringCharacter: "*",
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,
          textInputAction: widget.textInputAction ?? TextInputAction.done,
          style: kBodyRegularRegular.copyWith(color: AppColors.font1),
          onTap: widget.onTap,
          inputFormatters: [
            if (widget.keyboardType == TextInputType.number) ...[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,6})?$')),
            ] else if (widget.keyboardType == TextInputType.text) ...[
              FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9 ]*")),
            ],
            // if (widget.keyboardType == TextInputType.name) ...[
            //   FilteringTextInputFormatter.deny(RegExp(r"[0-9]")),
            //   FilteringTextInputFormatter.deny(
            //     RegExp(r'[~!@#$%^&*()_+`{}|<>?;:.,=[\]\\/\-]'),
            //   ),
            // ]
          ],
          decoration: InputDecoration(
            errorMaxLines: 3,
            contentPadding: EdgeInsets.symmetric(
              vertical: widget.height ?? 17.h,
              horizontal: widget.width ?? 16.w,
            ),
            counter: const Offstage(),
            isDense: widget.isDense,
            prefixIconConstraints: BoxConstraints.tight(
              Size(
                widget.prefixIconSize ?? 45.r,
                widget.prefixIconSize ?? 45.r,
              ),
            ),
            suffixIconConstraints: BoxConstraints.tight(
              Size(
                widget.suffixIconSizeWidth ?? 45.r,
                widget.suffixIconSizeHeight ?? 45.r,
              ),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? RPadding(
                    padding: REdgeInsets.only(right: 18.w),
                    child: InkWell(
                      onTap: _toggleVisibility,
                      child: Center(
                        child: CustomSvg(
                          icon: obscureText
                              ? Assets.iconsViewOn
                              : Assets.iconsViewOff,
                          color: AppColors.primary400,
                          size: 18.r,
                        ),
                      ),
                    ),
                  )
                : widget.suffixIcon == null
                    ? null
                    : InkWell(onTap: widget.onPress, child: widget.suffixIcon),
            focusedErrorBorder: border,
            focusedBorder: border,
            border: border,
            enabledBorder: border,
            filled: true,
            errorStyle: kBodySmallRegular.copyWith(color: AppColors.error1),
            hintStyle: widget.hintStyle ??
                kBodyRegularRegular.copyWith(color: AppColors.gray200),
            hintText: widget.hint ?? "",
            errorText: widget.errorText,
            fillColor: widget.fillColor ?? AppColors.white,
          ),
          validator: widget.validator,
          onSaved: widget.onSaved,
          onTapOutside: widget.onTapOutside,
          maxLines: widget.maxLines,
        ),
      ],
    );
  }

  void _toggleVisibility() => setState(() => obscureText = !obscureText);
}
