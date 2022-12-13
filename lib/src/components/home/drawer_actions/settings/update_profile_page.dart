import 'dart:io';

import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/app_snackbar.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/app_network_image.dart';
import 'package:be_universe/src/widgets/app_text_field.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reusables/utils/input_validator.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  var nameController = TextEditingController();
  var absorb = false;
  File? imageFile;
  var key = GlobalKey<FormState>();
  var validationMode = AutovalidateMode.disabled;

  ProfileResponse get user => AppData().readLastUser();

  @override
  void initState() {
    super.initState();
    nameController.text = AppData().readLastUser().name;
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    late dynamic child;
    if (imageFile != null) {
      child = Center(
          child: Stack(
        alignment: Alignment.topRight,
        children: [
          Image.file(
            imageFile!,
            fit: BoxFit.fill,
            height: 111,
            width: 111,
          ),
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.indigo, shape: BoxShape.circle),
              padding: const EdgeInsets.all(5.0),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ));
    } else if (user.image == null) {
      child = Center(
          child: Stack(
        alignment: Alignment.topRight,
        children: [
          Image.asset(
            AppAssets.defaultUser,
            fit: BoxFit.fill,
            height: 111,
            width: 111,
          ),
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.indigo, shape: BoxShape.circle),
              padding: const EdgeInsets.all(5.0),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ));
    } else {
      child = Center(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
                left: 10,
                top: 10,
                bottom: 10,
              ),
              child: AppNetworkImage(
                url: AppData().readLastUser().image!.fileUrl,
                borderRadius: 30,
                width: 111,
                height: 111,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 10,
              child: GestureDetector(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.indigo, shape: BoxShape.circle),
                  padding: const EdgeInsets.all(5.0),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: AbsorbPointer(
          absorbing: absorb,
          child: BackgroundImageWidget(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, padding.top + 56, 30, 20),
              // padding: EdgeInsets.only(
              //   top: padding.top + 56,
              //   left: 30,
              //   right: 30,
              //   bottom: 20,
              // ),
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: key,
                      autovalidateMode: validationMode,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Update Profile',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () async => await selectImage(context),
                            child: Center(child: child),
                          ),
                          const SizedBox(height: 30),
                          AppTextField(
                            textEditingController: nameController,
                            hint: 'Enter new name',
                            keyboardType: TextInputType.text,
                            validator: InputValidator.required(
                              message: 'Name is required',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppButtonWidget(
                    onPressed: submit,
                    before: () => setState(() => absorb = true),
                    after: () => setState(() => absorb = false),
                    title: 'Save',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage({required ImageSource imageSource}) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    } else {
      debugPrint('No Image Selected');
    }
  }

  Future<void> submit() async {
    if (!key.currentState!.validate()) {
      validationMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }
    if (imageFile == null) {
      $showSnackBar(context, 'Image is required');
      return;
    }
    try {
      final saveResponse = await FaqApi().saveFile(imageFile!);
      await ProfileApi().updateProfile(
        user.userid,
        ProfileUpdateRequest(
          image: saveResponse.name,
          name: nameController.text.trim(),
        ),
      );
      user.name = nameController.text;
      user.image = saveResponse.name;
      await AppData().saveUser(user);
      print('=========');
      print(user.image);
      nameController.clear();
      if (!mounted) return;
      $showSnackBar(context, 'updated successfully');
      Navigator.pop(context);
    } catch (_) {
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
                  await pickImage(imageSource: ImageSource.gallery);
                  if (mounted) {
                    await AppNavigation.pop(context);
                  }
                },
              ),
              getPickerTile(
                icon: CupertinoIcons.camera,
                title: 'Camera',
                onTap: () async {
                  await pickImage(imageSource: ImageSource.camera);
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
      leading: Icon(
        icon,
        size: 20,
        color: Colors.indigo,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      onTap: onTap,
    );
  }
}
