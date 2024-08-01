import 'dart:io';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskitly/core/models/order_stats_response.dart';

import '../../../../core/models/all_selected_categories_list.dart';
import '../../../../core/models/get-category-response.dart';
import '../../../../core/models/prodiders-service-response.dart';
import '../../../../core/models/skills-response.dart';
import '../../../../core/models/user_data.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/snack_message.dart';
import '../../../auth/get-started/sign-up/provider/services/service-screen-option.dart';
import '../../../auth/get-started/sign-up/provider/services/skills-screen-option.dart';
import '../../../base/base.vm.dart';
import '../../../widgets/bottomSheet.dart';

class EditServiceViewModel extends BaseViewModel {
  GetCategoryResponse? categoryResponse;
  GetSkillsResponse? skillResponse;
  List<Category> categories = [];
  List<Skill> skills = [];
  Category? category;
  List<Skill> selectedSkills = [];
  String? selectedSkill;
  List<String> selectedSkillSet = [];
  ProviderUserResponse? serviceDetailsData;
  OrderStats? orderStats;

  String? serviceRating;
  String serviceId = "";

  gotoEditServiceDetails() {
    navigationService.navigateTo(editServiceDetailsRoute).whenComplete(init);
  }

  init() async {
    getLocalCategories();
    getCategories();
    await getStoredServiceProviderDetails();
    
     serviceId = serviceDetailsData?.uid ?? "";
    if (serviceId.isNotEmpty) {
      await fetchOrderStats(serviceId: serviceId);
    }
  }

  String formatSkillsString(List<Skill> skills) {
    if (skills.isEmpty) {
      return '';
    }

    List<String> skillNames = skills.map((skill) => skill.name!).toList();
    return skillNames.join(', ');
  }

  selectCategory(Category? cat) async {
    category = categories.firstWhere((element) => element.uid == cat?.uid);
    print(category?.uid);
    onChange("");
    notifyListeners();
    await getSkills(category?.uid ?? "");
  }

  selectSkill(Skill skill) async {
    if (selectedSkills.any((element) => element == skill)) {
      selectedSkills.remove(skill);
    } else {
      selectedSkills.add(skill);
    }
    selectedSkill = formatSkillsString(selectedSkills);
    selectedSkillSet = selectedSkills.map((e) => e.name ?? "").toList();
    print(selectedSkill);
    onChange("");
    notifyListeners();
  }

  selectStringSkill(String skill) async {
    if (selectedSkills.any((element) => element.name == skill)) {
      selectedSkills
          .remove(skills.firstWhere((element) => element.name == skill));
    } else {
      selectedSkills.add(skills.firstWhere((element) => element.name == skill));
    }
    selectedSkill = formatSkillsString(selectedSkills);
    selectedSkillSet = selectedSkills.map((e) => e.name ?? "").toList();
    onChange("");
    notifyListeners();
  }

  clear() async {
    skillResponse = GetSkillsResponse();
    skills.clear();
    selectedSkill = "";
    notifyListeners();
  }

  getSkills(String categoryID) async {
    await clear();
    await getLocalSkills(categoryID);
    await getCategoriesSkills(categoryID);
    if (serviceDetailsData?.skills != null) {
      List<String> userSkills = serviceDetailsData?.skills ?? [];
      for (var skill in userSkills) {
        selectStringSkill(skill);
      }
    }
  }

  getLocalSkills(String categoryID) async {
    var response = await repository.getLocalSkills(categoryID);
    if (response?.results != null) {
      skillResponse = response;
      skills = response?.results ?? [];
    }
    notifyListeners();
  }

  Future<GetSkillsResponse?> getCategoriesSkills(String categoryID) async {
    startLoader();
    try {
      var response = await repository.getCategoriesSkills(categoryID);
      if (response?.results != null) {
        skillResponse = response;
        skills = response?.results ?? [];
      }
      stopLoader();
      notifyListeners();
      return skillResponse;
    } catch (err) {
      print(err);
      stopLoader();
      notifyListeners();
      return null;
    }
  }

 Future<dynamic> fetchOrderStats({required String serviceId}) async {
  startLoader();
  try {
    debugPrint('no fetched');
    var response = await repository.fetchOrderStats(serviceId: serviceId);
    debugPrint(response.toString());

    // Parse the response to a Map<String, dynamic>
    Map<String, dynamic> orderStats = response is String
        ? jsonDecode(response)
        : response;

    // Update averageRating and completionRate only if orderStats is not null
    if (orderStats != null) {
      averageRating = orderStats['average_rating'] ?? 0.0;
      completionRate = orderStats['completion_rate'] ?? 0.0;
    }
    debugPrint('success');
    stopLoader();
    notifyListeners();
  } on Exception catch (e) {
    print("Error fetching order stats: ${e.toString()}");
    stopLoader();
  }
  return null;
}


  var companyNameController = TextEditingController();
  var minimumAmountController = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();

  var descriptionController = TextEditingController();

  fillTextFields() {
    print("START");
    companyNameController =
        TextEditingController(text: serviceDetailsData?.companyName ?? "");
    countryController =
        TextEditingController(text: serviceDetailsData?.country ?? "");
    stateController =
        TextEditingController(text: serviceDetailsData?.state ?? "");
    minimumAmountController =
        TextEditingController(text: "${serviceDetailsData?.amount ?? ""}");
    descriptionController =
        TextEditingController(text: serviceDetailsData?.description ?? "");
    toWorkDays = workDays;
    toWorkTime = workTime;
    startDay = selectStartDay(serviceDetailsData?.weekdays?.first ?? "");
    startTime =
        selectStartTime((serviceDetailsData?.startHour ?? "").substring(0, 5));
    endTime =
        selectEndTime((serviceDetailsData?.endHour ?? "").substring(0, 5));
    // endDay = selectEndDay(serviceDetailsData?.weekdays?.last??"");
    selectCategory(serviceDetailsData?.category);
    print("DONE");
    notifyListeners();
  }

  getDaysInRange() {
    if (startDay == null && endDay == null) {
      return [];
    }

    int startIndex = workDays.indexOf(startDay ?? "");
    int endIndex = workDays.indexOf(endDay ?? "");

    if (startIndex == -1 || endIndex == -1) {
      return [];
    }

    // Extract the days in the specified range
    List<String> daysInRange = workDays.sublist(startIndex, endIndex + 1);

    weekDays = daysInRange;
    print(weekDays);
    return weekDays;
  }

  Future<GetCategoryResponse?> getLocalCategories() async {
    startLoader();
    var response = await repository.getLocalCategories();
    categoryResponse = response;
    if (response?.results != null) {
      categories = response?.results ?? [];
    }
    stopLoader();
    notifyListeners();
    return response;
  }

  Future<GetCategoryResponse?> getCategories() async {
    startLoader();
    try {
      var response = await repository.getCategories();
      categoryResponse = response;
      if (response?.results != null) {
        categories = response?.results ?? [];
      }
      stopLoader();
      notifyListeners();
      return response;
    } catch (err) {
      print(err);
      stopLoader();
      notifyListeners();
      return null;
    }
  }

  onChange(String? val) {
    formKey.currentState?.validate();
    notifyListeners();
  }

  selectStartDay(String? val) {
    startDay = val;
    // toWorkDays = getRemainingDays(val ?? "");
    onChange("");
    notifyListeners();
  }

  selectStartTime(String? val) {
    startTime = val;
    toWorkTime = getRemainingTime(val ?? "");
    onChange("");
    notifyListeners();
  }

  selectEndDay(String? val) async {
    endDay = val;
    await getDaysInRange();
    onChange("");
    notifyListeners();
  }

  selectEndTime(String? val) {
    endTime = val;
    onChange("");
    notifyListeners();
  }

  String? startDay;
  String? startTime;

  String? endDay;
  String? endTime;

  List<String> getRemainingDays(String selectedDay) {
    int selectedIndex = workDays.indexOf(selectedDay);
    if (selectedIndex == -1) {
      return [];
    }

    // Extract the remaining days starting from the selected day
    List<String> remainingDays = workDays.sublist(selectedIndex);

    return remainingDays;
  }

  List<String> getRemainingTime(String selectedDay) {
    int selectedIndex = workTime.indexOf(selectedDay);
    if (selectedIndex == -1) {
      return [];
    }

    // Extract the remaining days starting from the selected day
    List<String> remainingTimes = workTime.sublist(selectedIndex + 1);

    return remainingTimes;
  }

  List<String> workDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List<String> toWorkDays = [];
  List<String> weekDays = [];
  List<String> toWorkTime = [];

  List<String> workTime = [
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
    "24:00",
  ];

  showSelectServiceBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: navigationService.navigatorKey.currentState!.context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
          child: ServiceScreenOption(
        categories: categories,
        selectCategory: selectCategory,
      )),
    );
  }

  showSelectSkillsBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: navigationService.navigatorKey.currentState!.context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
          child: SkillsScreenOption(
        skill: skills,
        selectSkill: selectSkill,
        selectedSkill: selectedSkills,
      )),
    );
  }

  submit() async {
    startLoader();
    RegisterProviderData data = RegisterProviderData(
      companyName: companyNameController.text.trim(),
      description: descriptionController.text.trim(),
      amount: minimumAmountController.text.trim(),
      country: countryController.text.trim(),
      state: stateController.text.trim(),
      skill: selectedSkillSet,
      categoryID: category?.uid,
      startTime: startTime,
      endTime: endTime,
      weekDays: weekDays,
      registerResponse: appCache.registerResponse,
    );
    try {
      var response = await repository.registerProvider(data: data);
      if (response?.uid != null) {
        showCustomToast("Service provider detail update successfully",
            success: true);
        init();
      }
    } catch (err) {
      print(err);
    }
    stopLoader();
    notifyListeners();
  }

  // SERVICE
  double ratingValue = 0;
  bool switchValue = false;
  double averageRating = 0.0;

  double completionRate = 0;
  // String imageurl = "";
  XFile? pickedImage;

  void onRatingChanged(double? value) {
    if (value != null) {
      averageRating = value;
      notifyListeners();
    }
  }

  ProviderUserResponse serviceProvider = ProviderUserResponse();

  // void calculateAverageRating() {
  //   if (orderStats?.averageRating != null) {
  //     double sum = 0.0;
  //     for (var rating in orderStats?.averageRating ?? 0.0) {
  //       sum += rating.rating ?? 0.0;
  //     }
  //     averageRating = orderStats!.averageRating
  //         ? 0.0
  //         : sum / orderStats!.averageRating;
  //     averageRating = double.parse(averageRating.toStringAsFixed(2));
  //     notifyListeners();
  //   } else {
  //     averageRating = 0.0;
  //   }
  // }

  onSwitchChanged(bool? value) async {
    switchValue = value!;
    await updateOnlineStatus();
    notifyListeners();
  }

  updateOnlineStatus() async {
    startLoader();
    var payload =
        ProviderUserResponse(provider: Provider(isOnline: switchValue));
    try {
      var response = await repository.updateOnlineOffline(
          data: payload, serviceID: serviceDetailsData?.uid ?? "");
      if (response != null) {
        await getServiceProviderDetails();
      }
    } catch (err) {
      print(err);
    }
    stopLoader();
    notifyListeners();
  }

  Future<void> updateServiceDetails() async {
    startLoader();
    var payload = ProviderUserResponse(
      companyName: companyNameController.text.trim(),
      description: descriptionController.text.trim(),
      amount: double.tryParse(minimumAmountController.text.trim()),
      country: countryController.text.trim(),
      state: stateController.text.trim(),
      skills: selectedSkillSet,
      category: serviceDetailsData?.category,
      startHour: startTime,
      endHour: endTime,
      weekdays: weekDays,
      // ratings: Rating(rating: double.tryParse("$serviceRating")),
      image: pickedImage?.path,
    );
    try {
      var response = await repository.updateServiceProviderDetails(
          data: payload, serviceID: serviceDetailsData?.uid ?? "");
      if (response != null) {
        await getServiceProviderDetails();
      }
    } catch (err) {
      print(err);
    }
    stopLoader();
    notifyListeners();
  }

  // get service details data from storage
  Future<void> getStoredServiceProviderDetails() async {
    try {
      var response = await repository.getLocalServiceDetail();
      debugPrint("Fetched service details: ${response.toString()}");
      if (response != null) {
        serviceDetailsData = response;
        switchValue = response.provider?.isOnline ?? false;
        await fillTextFields();
      }
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  // get service details data from API
  Future<void> getServiceProviderDetails() async {
    try {
      await repository.getUserServiceDetail();
      await getStoredServiceProviderDetails();
      await init();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  // IMAGE
  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    // final isImageSizeBig = await checkImageSizeAndShowSnackbar(pickedFile);
    //
    // if (!isImageSizeBig) {
    //   return;
    // }
    if (pickedFile != null) {
      final imageBytes = await File(pickedFile.path).readAsBytes();

      pickedImage = pickedFile;

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

        // imageurl = "";
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
}
