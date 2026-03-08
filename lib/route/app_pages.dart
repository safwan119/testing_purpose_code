import 'package:get/get.dart';
import 'package:testing_purpose/chart/chart_practise.dart';
import 'package:testing_purpose/stripe/stripe_practise_view.dart';

class AppPages {
  static const String chartPractise = "/chart_practise_view";
  static const String stripePractiseView = "/stripe_practise_view";
  static List<GetPage> routes = [
    GetPage(name: chartPractise, page: () => ChartPractise()),
    GetPage(name: stripePractiseView, page: () => StripePractiseView()),
  ];
}
