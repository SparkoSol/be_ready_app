import 'package:be_ready_app/src/base/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.borderColor,
    Key? key,
    this.hint,
    this.onTap,
    this.label,
    this.value,
    this.obscure = false,
    this.suffix,
    this.onSaved,
    this.onChanged,
    this.readonly = false,
    this.validator,
    this.keyboardType,
    this.floatLabel = false,
    this.textEditingController,
    this.isBold = false,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.fillColor,
    this.style,
    this.bottomPadding,
    this.focusedBorderColor,
    this.prefix,
    this.hintStyle,
    this.hintColor,
    this.showBorder = true,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 23,
      horizontal: 12,
    ),
    this.borderRadius,
    this.maxLength,
    this.prefixText,
    this.prefixStyle,
    this.textAlign,
    this.focusNode,
  }) : super(key: key);

  final int? maxLength;
  final EdgeInsets contentPadding;
  final bool? isBold;
  final double? bottomPadding;
  final TextStyle? style;
  final bool? obscure;
  final String? hint;
  final String? label;
  final String? value;
  final bool readonly;
  final Widget? suffix;
  final bool? floatLabel;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? textEditingController;
  final int? maxLines;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final Color? focusedBorderColor;
  final Widget? prefix;
  final TextStyle? hintStyle;
  final Color? hintColor;
  final bool showBorder;
  final double? borderRadius;
  final Color? borderColor;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final TextAlign? textAlign;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 21),
      child: TextFormField(
        focusNode: focusNode,
        textAlign: textAlign ?? TextAlign.start,
        onTap: onTap,
        onSaved: onSaved,
        onChanged: onChanged,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        initialValue: value,
        maxLines: maxLines,
        readOnly: readonly,
        maxLength: maxLength,
        //minLines: minLines,
        validator: validator,
        obscureText: obscure ?? false,
        controller: textEditingController,
        scrollPadding: const EdgeInsets.all(100),
        cursorColor: Colors.white,
        style: style ??
            GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: hintColor ?? Colors.white,
            ),
        decoration: InputDecoration(
          counterText: '',
          prefixText: prefixText,
          prefixStyle: prefixStyle,
          contentPadding: contentPadding,
          prefixIcon: prefix,
          labelText: label,
          hintText: hint ?? '',
          suffixIcon: suffix,
          hintStyle: hintStyle ??
              GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: hintColor ?? const Color(0xFF747688),
              ),
          enabledBorder: OutlineInputBorder(
            // borderSide: BorderSide(
            //   color: showBorder
            //       ? borderColor ?? const Color(0xFFE1E1E1)
            //       : Colors.transparent,
            //   width: 1,
            // ),
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
          border: OutlineInputBorder(
            // borderSide: BorderSide(
            //   color: showBorder
            //       ? borderColor ?? const Color(0xFFE1E1E1)
            //       : Colors.transparent,
            //   width: 1,
            // ),
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
          focusedBorder: OutlineInputBorder(
            // borderSide: BorderSide(
            //   color: showBorder
            //       ? focusedBorderColor == null
            //           ? const Color(0xFFE1E1E1)
            //           : focusedBorderColor!
            //       : Colors.transparent,
            //   width: 1,
            // ),
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
          filled: true,
          fillColor: fillColor ?? const Color(0xFF2E2340),
        ),
      ),
    );
  }
}

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    Key? key,
    this.icon,
    this.label,
    this.validator,
    this.hint,
    this.context,
    this.iconBool,
    this.textEditingController,
    this.padding,
    this.textInputAction,
    this.onSaved,
    this.onChanged,
    this.prefix,
  }) : super(key: key);

  final FormFieldSetter<String>? onSaved;
  final IconData? icon;
  final String? hint;
  final Widget? prefix;
  final bool? iconBool;
  final String? label;
  final BuildContext? context;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onChanged;
  final TextEditingController? textEditingController;
  final EdgeInsetsGeometry? padding;
  final TextInputAction? textInputAction;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _show = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(bottom: 21),
      child: TextFormField(
        onSaved: widget.onSaved,
        validator: widget.validator,
        cursorColor: Colors.white,
        obscureText: _show,
        onChanged: widget.onChanged,
        controller: widget.textEditingController,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context).nextFocus();
        },
        scrollPadding: const EdgeInsets.all(100),
        decoration: InputDecoration(
          prefixIcon: widget.prefix,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 23,
            horizontal: 12,
          ),
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: const Color(0xFF747688),
          ),
          enabledBorder: OutlineInputBorder(
            // borderSide: BorderSide(
            //   color: showBorder
            //       ? borderColor ?? const Color(0xFFE1E1E1)
            //       : Colors.transparent,
            //   width: 1,
            // ),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            // borderSide: BorderSide(
            //   color: showBorder
            //       ? borderColor ?? const Color(0xFFE1E1E1)
            //       : Colors.transparent,
            //   width: 1,
            // ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            // borderSide: BorderSide(
            //   color: showBorder
            //       ? focusedBorderColor == null
            //           ? const Color(0xFFE1E1E1)
            //           : focusedBorderColor!
            //       : Colors.transparent,
            //   width: 1,
            // ),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: const Color(0xFF2E2340),
          labelText: widget.label,
          hintText: widget.hint,
          suffixIcon: InkWell(
            onTap: () => setState(
              () => _show = !_show,
            ),
            child: Image.asset(
              AppAssets.hiddenIcon,
              color: _show ? null : Colors.white,
            ),
          ),
        ),
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}
