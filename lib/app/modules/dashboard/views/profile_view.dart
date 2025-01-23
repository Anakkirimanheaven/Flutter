import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bismillah/app/data/profile_response.dart';
import 'package:bismillah/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.logout,
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<ProfileResponse>(
          future: controller.getProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              var data = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Name: ${data.name}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Email: ${data.email}"),
                  ),
                ],
              );
            } else {
              return Text("No data available");
            }
          },
        ),
      ),
    );
  }
}