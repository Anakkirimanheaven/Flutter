import 'package:bismillah/app/modules/dashboard/views/dashboard_view.dart';
import 'package:bismillah/app/modules/login/views/login_view.dart';
import 'package:bismillah/app/utils/api.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final _getConnect = GetConnect();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authToken = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void loginNow() async {
    final Response = await _getConnect.post(BaseUrl.login, {
      'email': emailController.text,
      'password': passwordController.text,
    });

    if (Response.statusCode == 200) {
      authToken.write('token', Response.body['token']);
      Get.offAll(() => const DashboardView());
    } else {
      Get.snackbar(
        'Error',
        Response.body['error'].toString(),
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        forwardAnimationCurve: Curves.bounceIn,
        margin: const EdgeInsets.only(
          top: 10,
          left: 5,
          right: 5,
        ),
      );
    }
  }
}
