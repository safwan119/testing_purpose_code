import 'package:get/get.dart';

class DropdownController extends GetxController {
  RxString? selectedValue = 'Select country'.obs;

  void onChangeValue(String? value) {
    selectedValue!.value = value!;
  }
}
