import 'dart:io';

import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/app_snackbar.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/home/drawer_actions/widget/drawer_action_title_widget.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/app_text_field.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reusables/reusables.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  var _absorb = false;
  File? _imageFile;
  var key = GlobalKey<FormState>();
  var validationMode = AutovalidateMode.disabled;

  Future<void> _pickImage({required ImageSource imageSource}) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      debugPrint('No Image Selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: AbsorbPointer(
          absorbing: _absorb,
          child: BackgroundImageWidget(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 30, right: 30, top: padding.top + 56, bottom: 30),
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: key,
                      autovalidateMode: validationMode,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DrawerActionTitleWidget(title: 'Contact Us'),
                          AppTextField(
                            keyboardType: TextInputType.emailAddress,
                            textEditingController: _emailController,
                            prefix: Image.asset(AppAssets.messageIcon),
                            hint: 'Contact Email',
                            validator: InputValidator.email(
                                message: 'Email is required'),
                          ),
                          AppTextField(
                            textEditingController: _subjectController,
                            hint: 'Add Subject',
                            validator: InputValidator.required(
                                message: 'Subject is required'),
                          ),
                          AppTextField(
                            textEditingController: _messageController,
                            hint: 'Message',
                            validator: InputValidator.required(
                                message: 'Message is required'),
                            maxLines: 5,
                          ),
                          GestureDetector(
                            onTap: () async => await selectImage(context),
                            child: Row(children: [
                              Image.asset(
                                AppAssets.attachmentIcon,
                                height: 24,
                                width: 24,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 4),
                                child: Text(
                                  'Attach File',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Text(
                                '(Max upload 5Mb)',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                ),
                              ),
                            ]),
                          ),
                          if (_imageFile != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                _imageFile!.path.split('/').last,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          // const SizedBox(height: 21),
                        ],
                      ),
                    ),
                  ),
                  AppButtonWidget(
                    onPressed: submit,
                    before: () => setState(() => _absorb = true),
                    after: () => setState(() => _absorb = false),
                    title: 'Send',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submit() async {
    if (!key.currentState!.validate()) {
      validationMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }
    if (_imageFile == null) {
      $showSnackBar(context, 'File is required');
      return;
    }

    try {
      final saveResponse = await FaqApi().saveFile(_imageFile!);
      await FaqApi().sendMessage(ContactUsRequest(
          email: _emailController.text.trim(),
          subject: _subjectController.text.trim(),
          message: _messageController.text.trim(),
          attachment: saveResponse.name));

      if (!mounted) return;
      $showSnackBar(context, 'sended successfully');
      Navigator.pop(context);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> selectImage(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            10,
            10,
            10,
            MediaQuery.of(context).padding.bottom + 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getPickerTile(
                icon: CupertinoIcons.folder,
                title: 'Gallery',
                onTap: () async {
                  await _pickImage(imageSource: ImageSource.gallery);
                  if (mounted) {
                    await AppNavigation.pop(context);
                  }
                },
              ),
              getPickerTile(
                icon: CupertinoIcons.camera,
                title: 'Camera',
                onTap: () async {
                  await _pickImage(imageSource: ImageSource.camera);
                  if (mounted) {
                    await AppNavigation.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getPickerTile({
    required IconData icon,
    required String title,
    required Function() onTap,
  }) {
    return ListTile(
      dense: true,
      leading: Icon(icon, size: 20),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      onTap: onTap,
    );
  }
}
