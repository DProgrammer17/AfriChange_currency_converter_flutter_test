import 'package:africhange_flutter_test/custom/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class GraphAsset30 extends StatefulWidget{
  ///These strings take in the conversionTO currency code and the current rate to be displayed on the tooltip of the graph
  String? base;
  String? rate;
  GraphAsset30({Key? key, this.base, this.rate}) : super(key: key);
  @override
  State<GraphAsset30> createState() => _GraphAsset30State();
}

class _GraphAsset30State extends State<GraphAsset30>{

  ///This is the list of graph data the graph is displaying
  List<ChartData> chartData = [
    ChartData(DateTime(2020, 06, 01), 30),
    ChartData(DateTime(2020, 06, 07), 46),
    ChartData(DateTime(2020, 06, 15), 29),
    ChartData(DateTime(2020, 06, 23), 36),
    ChartData(DateTime(2020, 06, 30), 48),
  ];

  @override
  Widget build(BuildContext context) {
    ///This is the tooltip of the graph
    TooltipBehavior _tooltipBehavior = TooltipBehavior(
      enable: true,
      canShowMarker: false,
      header: '${widget.base} : ${widget.rate}',
      color: Color(0xFF01B252),
      borderWidth: 0,
      textAlignment: ChartAlignment.near,
      textStyle: TextStyle(
        fontFamily: 'Monsterrat',
        fontSize: 11,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
    var size = MediaQuery.of(context).size;
    ///These lists setup the colors to be used to the graph gradient
    final List<Color> color = <Color>[Color(0xFF185DFA).withOpacity(0.5), Color(0xFF185DFA).withOpacity(0.7), Color(0xFF185DFA)];
    final List<double> stops = <double>[0.0, 0.5, 1.0];
    final LinearGradient gradientColors =
    LinearGradient(colors: color, begin: Alignment.topLeft, end: Alignment.bottomRight, stops: stops);

    return Container(
      child: Container(
        width: size.width,
        ///The package sfCartesian is used to create the graph widget
        child: SfCartesianChart(
          tooltipBehavior: _tooltipBehavior,
            plotAreaBorderWidth: 0,
            primaryXAxis: DateTimeAxis(
              dateFormat: DateFormat('dd MMM'),
              intervalType: DateTimeIntervalType.days,
                interval: 7,
                autoScrollingMode: AutoScrollingMode.start,
                majorGridLines: MajorGridLines(width: 0),
                majorTickLines: MajorTickLines(width: 0.5, size: 1.5),
                axisLine: AxisLine(
                  color: Colors.transparent,
                  width: 0,
                ),
              labelStyle: TextStyle(
                fontFamily: 'Monsterrat',
                fontSize: 8.5,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            primaryYAxis: NumericAxis(
              majorTickLines: MajorTickLines(width: 1, size: 1.5),
              majorGridLines: MajorGridLines(width: 0),
              axisLine: AxisLine(
                color: Colors.transparent,
                width: 0,
              ),
                labelStyle: TextStyle(
                    color: Colors.transparent,
                ),
            ),
            series: <ChartSeries>[
              SplineAreaSeries<ChartData, DateTime>(
                  dataSource: chartData,
                  xValueMapper: (ChartData sales, _) => sales.x,
                  yValueMapper: (ChartData sales, _) => sales.y,
                gradient: gradientColors,
              ),
            ]
        ),
      ),
    );
  }

}