import 'package:testing_purpose/chart/point_data.dart';

class PriceData {
  static List<PointData> pricePointList = [
    PointData(
      dateTime: DateTime.now().subtract(Duration(hours: 1)),
      price: 1550.0,
    ),
    PointData(
      dateTime: DateTime.now().subtract(Duration(hours: 5)),
      price: 1500.0,
    ),
    PointData(
      dateTime: DateTime.now().subtract(Duration(hours: 3)),
      price: 1400.0,
    ),
    PointData(
      dateTime: DateTime.now().subtract(Duration(hours: 2)),
      price: 1600.0,
    ),
    PointData(
      dateTime: DateTime.now().subtract(Duration(hours: 4)),
      price: 1200.0,
    ),
    PointData(
      dateTime: DateTime.now().subtract(Duration(hours: 2)),
      price: 1300.0,
    ),
    PointData(
      dateTime: DateTime.now().subtract(Duration(hours: 3)),
      price: 1100.0,
    ),
  ];
}
