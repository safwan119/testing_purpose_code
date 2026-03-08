import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:testing_purpose/chart/point_data.dart';

class ChartController extends GetxController {
  final priceData = <PointData>[].obs;
  Timer? _timer;
  final _random = Random();
  final RxDouble _currentPrice = 1000.0.obs;
  final changeValue = 0.0.obs;

  RxDouble get currentPrice => _currentPrice;
  final RxBool isUp = false.obs;

  @override
  void onInit() {
    super.onInit();
    _startLiveData();
  }

  void _startLiveData() {
    priceData.add(
      PointData(dateTime: DateTime.now(), price: _currentPrice.value),
    );
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _generateNextPrice();
    });
  }

  void _generateNextPrice() {
    final change = _random.nextDouble() * 40;
    isUp.value = _random.nextBool();
    changeValue.value = change;
    _currentPrice.value += isUp.value ? change : -change;
    priceData.add(
      PointData(dateTime: DateTime.now(), price: _currentPrice.value),
    );
    if (priceData.length >= 100) {
      priceData.removeAt(0);
    }
  }
}
