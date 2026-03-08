import 'package:get/get.dart';
import 'package:testing_purpose/controller/chart_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChartController>(ChartController(), permanent: true);
  }
}
