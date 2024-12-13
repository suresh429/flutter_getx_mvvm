import 'package:get/get.dart';

import '../model/LoginModel.dart';
import '../utilites/constants_Utils.dart';

class BottomNavController extends GetxController {
  var loginResponse = Rxn<LoginModel?>();

  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
   refresh();
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    loginResponse.value = await ConstantsUtils.getStoredLoginResponse();
  }

}
