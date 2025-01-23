import 'dart:async';
import 'package:bismillah/app/modules/dashboard/views/dashboard_view.dart';
import 'package:bismillah/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  late Timer _pindah;
  final authToken = GetStorage();
  @override
  void onInit() {
    _pindah = Timer.periodic(
        const Duration(seconds: 4),
        (timer) => authToken.read('token') == null
            ? Get.off(
                () => const LoginView(),
                transition: Transition.leftToRight,
              )
            : Get.off(() => const DashboardView()));

    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    _pindah.cancel();
  }
}
