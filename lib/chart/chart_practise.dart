import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:testing_purpose/controller/chart_controller.dart';
import 'package:get/get.dart';

class ChartPractise extends StatelessWidget {
  const ChartPractise({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChartController>();
    // final sortedData = [...PriceData.pricePointList]
    //   ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    //
    // final spots = sortedData
    //     .asMap()
    //     .entries
    //     .map((e) => FlSpot(e.key.toDouble(), e.value.price))
    //     .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Chart Practise"),
        backgroundColor: Colors.lightGreenAccent.shade100,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Change Value:${controller.isUp.value ? "+" : "-"}${controller.changeValue.value.toStringAsFixed(2)}",
                ),
                Text(
                  "Current Price:${controller.currentPrice.value.toStringAsFixed(2)}",
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Obx(() {
            final sortedData = [...controller.priceData]
              ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

            if (sortedData.length < 2) {
              return const Center(child: Text("Waiting for data..."));
            }

            final spots = sortedData
                .asMap()
                .entries
                .map((e) => FlSpot(e.key.toDouble(), e.value.price))
                .toList();
            return AspectRatio(
              aspectRatio: 2.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 100,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: false,
                        verticalInterval: 4.0,
                        drawVerticalLine: true,
                        drawHorizontalLine: false,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.lightGreenAccent,
                            strokeWidth: 3.0,
                          );
                        },
                        checkToShowVerticalLine: (value) => true,
                      ),
                      lineTouchData: LineTouchData(
                        touchSpotThreshold: 5,
                        getTouchedSpotIndicator:
                            (LineChartBarData barData, List<int> spotIndex) {
                              return spotIndex
                                  .map(
                                    (spotIndex) => TouchedSpotIndicatorData(
                                      FlLine(
                                        color: Colors.lightGreenAccent,
                                        strokeWidth: 2,
                                      ),
                                      FlDotData(
                                        show: true,
                                        getDotPainter:
                                            (spot, percent, barData, index) =>
                                                FlDotCirclePainter(
                                                  strokeWidth: 8,
                                                  radius: 5,
                                                  strokeColor:
                                                      Colors.lightGreenAccent,
                                                  color: Colors.black,
                                                ),
                                      ),
                                    ),
                                  )
                                  .toList();
                            },
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (touchSpot) => Colors.transparent,
                        ),

                        getTouchLineEnd: (_, _) => double.infinity,
                        getTouchLineStart: (_, _) => -double.infinity,
                      ),

                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        show: false,
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                            getTitlesWidget: (value, titleMeta) {
                              final index = value.toInt();
                              if (index < 0 || index >= sortedData.length) {
                                return const SizedBox.shrink();
                              }
                              final data = sortedData[index].dateTime;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text("${data.hour} : ${data.minute} \t"),
                              );
                            },
                          ),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          color:controller.isUp.value? Colors.lightGreenAccent.shade400.withValues(
                            alpha: 2.9,
                          ):Colors.red,
                          spots: spots,
                          dotData: FlDotData(show: false),
                          isCurved: true,
                        ),
                      ],
                    ),
                    curve: Curves.linear,
                    duration: Duration(seconds: 1),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
