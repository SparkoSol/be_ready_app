import 'package:be_ready_app/src/base/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatefulWidget {
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
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(_listener);
    super.initState();
  }

  void _listener() => setState(() {});

  @override
  void dispose() {
    focusNode.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.bottomPadding ?? 21),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        gradient: (focusNode.hasFocus)
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF7491D4),
                  Color(0xFFDFDFA3),
                ],
              )
            : null,
      ),
      child: TextFormField(
        focusNode: focusNode,
        textAlign: widget.textAlign ?? TextAlign.start,
        onTap: widget.onTap,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        initialValue: widget.value,
        maxLines: widget.maxLines,
        readOnly: widget.readonly,
        maxLength: widget.maxLength,
        //minLines: minLines,
        validator: widget.validator,
        obscureText: widget.obscure ?? false,
        controller: widget.textEditingController,
        scrollPadding: const EdgeInsets.all(100),
        cursorColor: Colors.white,
        style: widget.style ??
            GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: widget.hintColor ?? Colors.white,
            ),
        decoration: InputDecoration(
          counterText: '',
          prefixText: widget.prefixText,
          prefixStyle: widget.prefixStyle,
          contentPadding: widget.contentPadding,
          prefixIcon: widget.prefix,
          labelText: widget.label,
          hintText: widget.hint ?? '',
          suffixIcon: widget.suffix,
          hintStyle: widget.hintStyle ??
              GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: widget.hintColor ?? const Color(0xFF747688),
              ),
          enabledBorder: OutlineInputBorder(
            // borderSide: BorderSide(
            //   color: showBorder
            //       ? borderColor ?? const Color(0xFFE1E1E1)
            //       : Colors.transparent,
            //   width: 1,
            // ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          ),
          border: OutlineInputBorder(
            // borderSide: BorderSide(
            //   color: showBorder
            //       ? borderColor ?? const Color(0xFFE1E1E1)
            //       : Colors.transparent,
            //   width: 1,
            // ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
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
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          ),
          filled: true,
          fillColor: widget.fillColor ?? const Color(0xFF2E2340),
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
  final focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(_listener);
    super.initState();
  }

  void _listener() => setState(() {});

  @override
  void dispose() {
    focusNode.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 21),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: (focusNode.hasFocus)
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF7491D4),
                  Color(0xFFDFDFA3),
                ],
              )
            : null,
      ),
      child: TextFormField(
        onSaved: widget.onSaved,
        validator: widget.validator,
        focusNode: focusNode,
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
