// viewmodels/user_viewmodel.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/user.dart';
import '../service/api_service.dart';
import '../service/network_checker.dart';
import '../utilites/error_handler.dart';


class UserViewModel extends GetxController {
  var users = <User>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  final ApiService apiService;

  UserViewModel({required this.apiService});

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    if (await NetworkChecker.isConnected()) {
      try {
        isLoading(true);
        users.value = await apiService.fetchUsers();
      } catch (e) {
        if (e is DioError) {
          errorMessage.value = ErrorHandler.handleError(e);
        } else {
          errorMessage.value = 'An unexpected error occurred.';
        }
      } finally {
        isLoading(false);
      }
    } else {
      errorMessage.value = "No internet connection";
    }
  }

  Future<void> addUser(User user) async {
    if (await NetworkChecker.isConnected()) {
      try {
        final newUser = await apiService.createUser(user);
        users.add(newUser);
      } catch (e) {
        if (e is DioError) {
          errorMessage.value = ErrorHandler.handleError(e);
        } else {
          errorMessage.value = 'An unexpected error occurred.';
        }
      }
    } else {
      errorMessage.value = "No internet connection";
    }
  }

  Future<void> updateUser(User user) async {
    if (await NetworkChecker.isConnected()) {
      try {
        final updatedUser = await apiService.updateUser(user);
        int index = users.indexWhere((u) => u.id == updatedUser.id);
        if (index != -1) {
          users[index] = updatedUser;
        }
      } catch (e) {
        if (e is DioError) {
          errorMessage.value = ErrorHandler.handleError(e);
        } else {
          errorMessage.value = 'An unexpected error occurred.';
        }
      }
    } else {
      errorMessage.value = "No internet connection";
    }
  }

  Future<void> deleteUser(int id) async {
    if (await NetworkChecker.isConnected()) {
      try {
        await apiService.deleteUser(id);
        users.removeWhere((user) => user.id == id);
      } catch (e) {
        if (e is DioError) {
          errorMessage.value = ErrorHandler.handleError(e);
        } else {
          errorMessage.value = 'An unexpected error occurred.';
        }
      }
    } else {
      errorMessage.value = "No internet connection";
    }
  }
}
