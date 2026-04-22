import 'package:get/get.dart';
import 'package:testing_purpose/chart/chart_practise.dart';
import 'package:testing_purpose/dropdown/custom_drop_down_state.dart';
import 'package:testing_purpose/dropdown/dropdown_practise_view.dart';
import 'package:testing_purpose/stripe/stripe_practise_view.dart';

class AppPages {
  static const String chartPractise = "/chart_practise_view";
  static const String stripePractiseView = "/stripe_practise_view";
  static const String dropdownView = "/dropdown_view";
  static const String customDropDown = "/custom_drop_down_view";
  static List<GetPage> routes = [
    GetPage(name: chartPractise, page: () => ChartPractise()),
    GetPage(name: stripePractiseView, page: () => StripePractiseView()),
    GetPage(name: dropdownView, page: () => DropdownPractiseView()),
    GetPage(name: customDropDown, page: () => CustomDropdown()),
  ];
}
