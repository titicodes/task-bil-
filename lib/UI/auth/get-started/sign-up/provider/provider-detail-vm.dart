import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskitly/core/models/service_provider_response_model.dart'
    as uPMs;
import 'package:taskitly/routes/routes.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../../../../constants/reuseables.dart';
import '../../../../../core/models/all_selected_categories_list.dart';
import '../../../../../core/models/get-category-response.dart';
import '../../../../../core/models/skills-response.dart';
import '../../../../../core/models/user_data.dart';
import '../../../../base/base.vm.dart';
import '../../../../widgets/bottomSheet.dart';
import 'services/service-screen-option.dart';
import 'services/skills-screen-option.dart';

class ProviderDetailViewModel extends BaseViewModel {
  GetCategoryResponse? categoryResponse;
  GetSkillsResponse? skillResponse;
  List<Category> categories = [];
  List<Skill> skills = [];
  Category? category;
  List<Skill> selectedSkills = [];
  String? selectedSkill;
  List<String> selectedSkillSet = [];
  uPMs.ServiceProviderResponseModel? serviceDetailsData;
  String serviceRating = "";

  init() async {
    getLocalCategories();
    getCategories();
  }

  String formatSkillsString(List<Skill> skills) {
    if (skills.isEmpty) {
      return '';
    }

    List<String> skillNames = skills.map((skill) => skill.name!).toList();
    return skillNames.join(', ');
  }

  gotoEditServiceDetail() {
    navigationService.navigateTo(editServiceDetailsRoute);
  }

  selectCategory(Category cat) async {
    category = cat;
    print(cat.uid);
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

  clear() async {
    skillResponse = GetSkillsResponse();
    skills.clear();
    selectedSkill = "";
    notifyListeners();
  }

  getSkills(String categoryID) async {
    await clear();
    getLocalSkills(categoryID);
    getCategoriesSkills(categoryID);
  }

  getLocalSkills(String categoryID) async {
    var response = await repository.getLocalSkills(categoryID);
    if (response?.results != null) {
      skillResponse = response;
      skills = response?.results ?? [];
    }
    notifyListeners();
  }

  Future<GetSkillsResponse?> getCategoriesSkills(String categoryID,
      {int? page}) async {
    startLoader();
    try {
      var response =
          await repository.getCategoriesSkills(categoryID, page: page);
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

  var companyNameController = TextEditingController();
  var minimumAmountController = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();
  var descriptionController = TextEditingController();

  fillTextFields() {
    companyNameController = TextEditingController(
        text: serviceDetailsData!.data!.first.companyName ?? "");
    countryController = TextEditingController(
        text: serviceDetailsData!.data!.first.country ?? "");
    stateController = TextEditingController(
        text: serviceDetailsData!.data!.first.state ?? "");
    minimumAmountController = TextEditingController(
        text: "${serviceDetailsData!.data!.first.amount ?? ""}");
    descriptionController = TextEditingController(
        text: serviceDetailsData!.data!.first.description ?? "");
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

  Future<GetCategoryResponse?> getCategories({int? page}) async {
    startLoader();
    try {
      final response = await repository.getCategories(page: page);
      categoryResponse = response;
      if (response?.results != null) {
        categories = response!.results!;
      } else {
        categories = [];
      }
      stopLoader();
      notifyListeners();
      return response;
    } catch (err) {
      print('Error fetching categories: $err');
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
    toWorkDays = getRemainingDays(val ?? "");
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
    final box = GetStorage();
    box.write(DbTable.TOKEN_TABLE_NAME, appCache.registerResponse.token);
    try {
      var response = await repository.registerProvider(data: data);
      if (response?.uid != null) {
        showCustomToast("Service provider detail update successfully",
            success: true);
        box.remove(DbTable.TOKEN_TABLE_NAME);
        navigationService.navigateToAndRemoveUntil(loginScreenRoute);
      }
      box.remove(DbTable.TOKEN_TABLE_NAME);
    } catch (err) {
      box.remove(DbTable.TOKEN_TABLE_NAME);
      print(err);
    }
    stopLoader();
    notifyListeners();
  }

  // SERVICE
  double ratingValue = 0;
  bool switchValue = false;
  // String imageurl = "";
  XFile? pickedImage;

  onRatingChanged(double? value) {
    ratingValue = value!;
    notifyListeners();
  }

  onSwitchChanged(bool? value) {
    switchValue = value!;
    notifyListeners();
  }
}
