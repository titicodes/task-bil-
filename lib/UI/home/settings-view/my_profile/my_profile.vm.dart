import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskitly/core/models/user_data.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../../../core/models/user-response.dart';
import '../../../base/base.vm.dart';

class MyProfileViewModel extends BaseViewModel {
  bool isEdit = false;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var userNameController = TextEditingController();
  var emailNameController = TextEditingController();

  String? selectedImage;
  File? selectedImageFile;

  User user = User();

  bool showEdit = false;

  pickImage() {
    showEdit = !showEdit;
    notifyListeners();
  }

  // selectImage({ImageSource source = ImageSource.camera}) async {
  //   pickImage();
  //   final ImagePicker picker = ImagePicker();
  //   final image = await picker.pickImage(source: source);
  //   if (image == null) {
  //     selectedImage = null;
  //     selectedImageFile = null;
  //   } else {
  //     var files = File(image.path.toString(),);
  //     selectedImageFile = files;
  //     selectedImage = image.path.toString();
  //   }
  //   notifyListeners();
  // }

  selectImage({ImageSource source = ImageSource.camera}) async {
    pickImage();
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image == null) {
      selectedImage = null;
      selectedImageFile = null;
    } else {
      selectedImageFile = File(image.path);
      selectedImage = image.path;
    }
    notifyListeners();
  }

  init() {
    isEdit = false;
    user = userService.user;
    firstNameController = TextEditingController(text: user.firstName ?? "");
    lastNameController = TextEditingController(text: user.lastName ?? "");
    userNameController = TextEditingController(text: user.username ?? "");
    emailNameController = TextEditingController(text: user.email ?? "");
    notifyListeners();
  }

  changeEdit() {
    isEdit = !isEdit;
    notifyListeners();
  }

  submit() async {
    startLoader();
    var data = UserData(
      firstName: firstNameController.text.trim().isEmpty
          ? userService.user.firstName
          : firstNameController.text.trim(),
      lastName: lastNameController.text.trim().isEmpty
          ? userService.user.lastName
          : lastNameController.text.trim(),
      email: emailNameController.text.trim().isEmpty
          ? userService.user.email
          : emailNameController.text.trim(),
      username: userNameController.text.trim().isEmpty
          ? userService.user.username
          : userNameController.text.trim(),
      image: selectedImageFile,
    );
    try {
      var response = await repository.updateProfile(data: data);
      if (response != null) {
        selectedImageFile == null;
        await repository.getUser();
        await init();
        showCustomToast("Profile updated Successfully", success: true);
      }
    } catch (err) {
      print(err);
    }
    stopLoader();
    notifyListeners();
  }
}
