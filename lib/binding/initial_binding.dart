import 'package:get/get.dart';
import 'package:testing_purpose/controller/chart_controller.dart';
import 'package:testing_purpose/controller/dropdown/dropdown_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChartController>(ChartController(), permanent: true);
    Get.put<DropdownController>(DropdownController(), permanent: true);
  }
}
