import '../../../../core/models/prodiders-service-response.dart';
import '../../../../routes/routes.dart';
import '../../../base/base.vm.dart';

class BookmarkViewModel extends BaseViewModel {
  BookmarkViewModel() {
    fetchBookMarkedProvider();
  }

  List<ProviderUserResponse> bookMarkedProvider = [];

  removeBookMark(ProviderUserResponse provider) async {
    try {
      await repository.removeBookMark(provider);
      await fetchBookMarkedProvider();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  fetchBookMarkedProvider() async {
    try {
      var response = await repository.getBookMarks();
      if (response != null) {
        bookMarkedProvider = response;
      }
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  navigateToDetails(ProviderUserResponse serviceID) async {
    appCache.serviceProvider = serviceID;
    navigationService
        .navigateTo(providerDetailViewRoute)
        .whenComplete(fetchBookMarkedProvider);
  }
}
