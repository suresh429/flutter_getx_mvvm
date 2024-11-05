import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/user.dart';
import '../service/api_service.dart';
import '../view_model/user_view_model.dart';

class UserListScreen extends StatelessWidget {
  final UserViewModel userViewModel = Get.put(UserViewModel(apiService: ApiService()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Users'),
          backgroundColor: Colors.white
      ),
      body: Obx(() {
        if (userViewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (userViewModel.errorMessage.isNotEmpty) {
          return Center(child: Text(userViewModel.errorMessage.value));
        }
        return ListView.builder(
          itemCount: userViewModel.users.length,
          itemBuilder: (context, index) {
            final user = userViewModel.users[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Update user logic here
                      userViewModel.updateUser(User(id: user.id, name: 'Updated ${user.name}', email: user.email));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Delete user logic here
                      userViewModel.deleteUser(user.id);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add user logic here
          userViewModel.addUser(User(id: 0, name: 'New User', email: 'newuser@example.com'));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}