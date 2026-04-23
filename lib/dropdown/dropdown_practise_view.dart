import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_purpose/controller/dropdown/dropdown_controller.dart';
import 'package:testing_purpose/dropdown/custom_drop_down_state.dart';

class DropdownPractiseView extends StatelessWidget {
  const DropdownPractiseView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> countrySelected = [
      "Select country",
      "Pakistan",
      "Iran",
      "Turkey",
    ];
    final dropDownController = Get.find<DropdownController>();
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Drop down practise")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Some thing"),
                Obx(
                  () => DropdownButton<String>(
                    isDense: true,
                    value: dropDownController.selectedValue!.value,
                    icon: Icon(Icons.arrow_drop_down_circle_outlined),
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: SizedBox(),
                    hint: Text("Select Country"),
                    items: countrySelected.map((e) {
                      return DropdownMenuItem(
                        value: e.toString(),
                        child: Row(children: [Text(e.toString())]),
                      );
                    }).toList(),
                    selectedItemBuilder: (context) =>
                        countrySelected.map((e) => SizedBox.shrink()).toList(),
                    onChanged: (value) =>
                        dropDownController.onChangeValue(value),
                  ),
                ),
              ],
            ),
            Obx(
              () => Text(
                dropDownController.selectedValue!.value,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            CustomDropdown(),
          ],
        ),
      ),
    );
  }
}
