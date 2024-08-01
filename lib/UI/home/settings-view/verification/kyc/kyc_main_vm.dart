import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/snack_message.dart';
import '../../../../base/base.vm.dart';
import '../../../../widgets/successful-pop-up.dart';

class KYCMainViewModel extends BaseViewModel {
  BuildContext? context;

  List<String> dropdownItemList = [
    "NIN",
    "Drivers License",
    "Passport",
    "Voters Card"
  ];

  List<String> dropdownItemList2 = ["Passport", "Voters Card"];

  String selectedType = "";
  bool photoVerifSelected = false;

  var enterCardIDNumberController = TextEditingController();

  var enterCardIDNumberController2 = TextEditingController();

  String imageurl = "";

  XFile? pickedImage;

  // onChange(String? val) {
  //   formKey.currentState!.validate();
  //   notifyListeners();
  // }

  void setContext(BuildContext ctx) {
    context = ctx;
  }

  void onChange(String? val) {
    if (!photoVerifSelected) {
      formKey.currentState!
          .validate(); // Validate only if photo verification is not selected
    }
    notifyListeners();
  }

  void handleVerifyIDPress() {
    if (photoVerifSelected != true) {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        verifyIDSubmit();
      }
    } else {
      // Handle photo verification case (if needed)
    }
    notifyListeners();
  }

  goToKYCphotoType() {
    navigationService.navigateTo(kycMainPhotoScreen);
  }

  gotoHome() {
    navigationService.navigateTo(homeRoute);
  }

  void callSuccesPopUp() {
    if (context == null) return;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context!,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => SuccessfulPopUpWidget(
        title: 'ID Uploaded',
        subTitle:
            "Your ID has been uploaded for verification.\nWe will let you know via email if it is verified.",
        buttonText: "Back Home",
        onTap: () {
          gotoHome();
        },
      ),
    );
  }

  onDropDownChanged(String? value) {
    selectedType = value!;
    if (selectedType == "Passport" || selectedType == "Voters Card") {
      photoVerifSelected = true;
    } else {
      photoVerifSelected = false;
    }
    debugPrint("SELECTED: $selectedType");
    notifyListeners();
  }

  init() async {}

  verifyIDSubmit() async {
    if (photoVerifSelected) {
      goToKYCphotoType();
    } else {
      var cardID = enterCardIDNumberController.text.trim();

      if (selectedType.isEmpty) {
        showCustomToast('Select verification type to proceed');
        return;
      }

      // if (cardID.isEmpty) {
      //   showCustomToast('Input card ID in order to proceed');
      //   return;
      // }

      if (selectedType == "NIN") {
        debugPrint('NIN verification started');
        verifyNIN();
      } else if (selectedType == "Drivers License") {
        debugPrint('Drivers License verification started');
        verifyDriversLicense(cardID);
      }
    }
  }

  uploadIDSubmit() {
    if (pickedImage == null) {
      showCustomToast('Please select an image');
    } else {
      var cardID = enterCardIDNumberController2.text.trim();

      if (selectedType == "Passport") {
        debugPrint('Passport verification started');
        verifyPassport(idNumber: cardID, image: imageurl);
      } else if (selectedType == "Voters Card") {
        debugPrint('Voters Card verification started');
        verifyVotersCard(idNumber: cardID, image: imageurl);
      }
    }
  }

  Future<void> verifyDriversLicense(String idNumber) async {
    startLoader();
    try {
      var response = await repository.verifyDriversLicensekYC(idNumber);
      stopLoader();
      if (response != null) {
        var decoded = response.data;
        callSuccesPopUp();
      }
      notifyListeners();
    } catch (err) {
      stopLoader();
      notifyListeners();
    }
  }

  Future<void> verifyVotersCard(
      {required String idNumber, required String image}) async {
    try {
      var response = await repository.verifyVotersCardkYC(
        idNumber: idNumber,
        image: File(pickedImage!.path),
      );
      stopLoader();
      if (response != null) {
        var decoded = response.data;
        callSuccesPopUp();
      }
      notifyListeners();
    } catch (err) {
      stopLoader();
      notifyListeners();
    }
  }

  
  var bvnController = TextEditingController();

  Future<void> verifyNIN() async {
    try {
      startLoader();
      final nin = bvnController.text.trim();
      if (nin.isEmpty) {
        throw Exception('Please enter your NIN');
      }
      var response = await repository.ninKycVerification(
        idNumber: nin,
        dob: formatDateForViewModel(dateOfBirth),
        type: "NIN",
      );
      stopLoader();
      if (response != null) {
        callSuccesPopUp();
      } else {
        // Handle null response (e.g., server error)
        showCustomToast(
            'An unexpected error occurred. Please try again later.');
      }
      notifyListeners();
    } catch (err) {
      stopLoader();
      showCustomToast(err.toString());
      notifyListeners();
    }
  }

  Future<void> verifyPassport(
      {required String idNumber, required String image}) async {
    try {
      var response = await repository.verifyPassportkYC(
        idNumber: idNumber,
        image: File(pickedImage!.path),
      );
      stopLoader();
      if (response != null) {
        var decoded = response.data;
        callSuccesPopUp();
      }
      notifyListeners();
    } catch (err) {
      stopLoader();
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    final isImageSizeBig = await checkImageSizeAndShowSnackbar(pickedFile);

    if (!isImageSizeBig) {
      return;
    }
    if (pickedFile != null) {
      final imageBytes = await File(pickedFile.path).readAsBytes();
      final imageBase64 = base64Encode(imageBytes);

      pickedImage = pickedFile;
      imageurl = imageBase64;
      print(imageurl);
      notifyListeners();
    }
  }

  Future<bool> checkImageSizeAndShowSnackbar(XFile? pickedFile) async {
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileLength = await file.length();

      // Check if the file size exceeds 1 MB (1,048,576 bytes)
      if (fileLength > 1048576) {
        // The image is too large, show a snackbar with a message
        showCustomToast("Image should not be greater than 1mb");

        // Clear the imageurl field

        imageurl = "";
        print("The picked image is : $pickedImage");
        pickedImage = null;
        print("The picked image after set to null is: $pickedImage");
        notifyListeners();
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  DateTime? dateOfBirth;
  DateTime dob = DateTime.now();

  Future<DateTime?> pickDateTime({
    required bool pickDate,
    required BuildContext context,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (date == null) return null;

      final time = Duration(hours: dob.hour, minutes: dob.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(dob),
      );
      if (timeOfDay == null) return null;

      final date = DateTime(dob.year, dob.month, dob.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Future<void> pickToDateTime({
    required bool pickDate,
    required BuildContext context, // Add context parameter
  }) async {
    //if (context == null) return; // Handle null context

    final date = await pickDateTime(
      pickDate: pickDate,
      context: context,
    );
    if (date == null) return;

    dob = date;
    dateOfBirth = date;
    notifyListeners();
  }

  String formatDateForViewModel(DateTime? date) {
    if (date != null) {
      return DateFormat('dd-MM-yyyy').format(date);
    }
    return '';
  }

  void onDateOfBirthChanged(DateTime? newDate) {
    dateOfBirth = newDate;
    notifyListeners();
  }
}
