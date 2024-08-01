import '../../../../base/base.vm.dart';

class BlockUserViewModel extends BaseViewModel {
  init() {
    getLocalBlockedUser();
    getBlockedUsers();
  }

  bool loadings = false;

  startNewLoading() async {
    loadings = true;
    notifyListeners();
  }

  stopNewLoading() async {
    loadings = false;
    notifyListeners();
  }

  unblockUser(String userID) async {
    startNewLoading();
    try {
      var response = await repository.unblockUser(userID: userID);
      await init();
    } catch (err) {
      print(err);
    }
    stopNewLoading();
    notifyListeners();
  }
}
