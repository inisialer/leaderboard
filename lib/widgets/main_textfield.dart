import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';

class MainTextFormField extends StatelessWidget {
  const MainTextFormField(
      {super.key,
      this.hintText,
      this.suffixIcon,
      this.readOnly,
      this.enabled,
      this.onTap,
      this.minLines = 1,
      this.obscureText,
      this.maxLines,
      this.controller,
      this.inputFormatters,
      this.validator,
      this.prefixIcon,
      this.onComplete,
      this.onChanged,
      this.border,
      this.hintStyle,
      this.keyboardType,
      this.label,
      this.errorText,
      this.labelTextRich1,
      this.labelTextRich2,
      this.prefixText,
      this.isTextRichLabel = false,
      this.contentPaddingVertical,
      this.contentPaddingHorizontal,
      this.onFieldSubmitted,
      this.filled,
      this.fillColor,
      this.style,
      this.borderRadius});
  final String? hintText;
  final String? prefixText;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  final bool? enabled;
  final bool? obscureText;
  final int? minLines;
  final void Function()? onTap;
  final int? maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onComplete;
  final void Function(String)? onChanged;
  final InputBorder? border;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final Widget? label;
  final String? labelTextRich1;
  final String? labelTextRich2;
  final bool? isTextRichLabel;
  final double? contentPaddingVertical;
  final double? contentPaddingHorizontal;
  final BorderRadius? borderRadius;
  final void Function(String)? onFieldSubmitted;
  final bool? filled;
  final Color? fillColor;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      minLines: minLines,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onComplete ??
          () {
            FocusScope.of(context).unfocus();
          },
      onChanged: onChanged,
      maxLines: maxLines ?? 1,
      obscureText: obscureText ?? false,
      enabled: enabled,
      onTap: onTap,
      readOnly: readOnly ?? false,
      style: style ??
          GoogleFonts.rubik(
            color: Color(0xFF7D8998),
          ),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        errorMaxLines: 2,
        errorText: errorText,
        filled: filled ?? true,
        fillColor: fillColor ?? Colors.white,
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        suffixIcon: suffixIcon,
        // counterText: '+852',

        // prefixStyle: const GoogleFonts.rubik(color: Colors.white),
        prefixIconConstraints: const BoxConstraints(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
            horizontal: contentPaddingHorizontal ?? 16,
            vertical: contentPaddingVertical ?? 16),
        isDense: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        hintText: hintText ?? "Masukkan password kamu",
        hintStyle: lightGrey16w400,
        label: isTextRichLabel!
            ? Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: labelTextRich1,
                      style: GoogleFonts.rubik(
                        color: greyBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                        letterSpacing: 0.15,
                      ),
                    ),
                    TextSpan(
                      text: labelTextRich2,
                      style: GoogleFonts.rubik(
                        color: Color(0xFFD91515),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 0.09,
                        letterSpacing: 0.15,
                      ),
                    ),
                  ],
                ),
              )
            : label,
      ),
      validator: validator ??
          (value) {
            if (value == null || value == "") {
              return 'This field required';
            }
            return null;
          },
    );
  }
}
