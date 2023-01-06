import 'dart:ui';

import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/app_text_field.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/reusables.dart';

class NameInputSheet extends StatefulWidget {
  const NameInputSheet({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final ProfileResponse profile;

  Future<ProfileResponse?> show(BuildContext context) async {
    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: this,
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
    );
  }

  @override
  State<NameInputSheet> createState() => _NameInputSheetState();
}

class _NameInputSheetState extends State<NameInputSheet> {
  final _formKey = GlobalKey<FormState>();
  var _autoValidateMode = AutovalidateMode.disabled;
  var _absorb = false;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: _absorb,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF728FD6), Color(0xFFE0DF9F)],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              // image: DecorationImage(
              //   image: AssetImage(AppAssets.starsIcon),
              //   fit: BoxFit.contain
              // ),
              color: Color(0xFF0B002A),
            ),
            margin: const EdgeInsets.all(3),
            padding: EdgeInsets.fromLTRB(
              30,
              20,
              30,
              10 + MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Update Name',
                  style: GoogleFonts.oswald(
                    fontSize: 33,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: AppTextField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.go,
                    hint: 'Enter your name',
                    // hintColor: Colors.grey,
                    validator: InputValidator.required(
                      message: 'Name is required',
                    ),
                    onSaved: (value) => widget.profile.name = value ?? '',
                  ),
                ),
                AppButtonWidget(
                  onPressed: submit,
                  before: () {
                    if (!mounted) return;
                    setState(() => _absorb = true);
                  },
                  after: () {
                    if (!mounted) return;
                    setState(() => _absorb = false);
                  },
                  title: 'Update',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) {
      _autoValidateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }
    try {
      _formKey.currentState!.save();
      await ProfileApi().updateProfile(
        widget.profile.userid,
        ProfileUpdateRequest(
          name: widget.profile.name,
          image: widget.profile.image,
        ),
      );
      if (!mounted) return;
      Navigator.of(context).pop(widget.profile);
    } catch (e) {
      rethrow;
    }
  }
}
