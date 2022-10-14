import 'package:finan_reports/models/serie.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatelessWidget {
  final List<Serie> data;

  Chart({required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<Serie, String>> series = [
      charts.Series(
          id: "developers",
          data: data,
          domainFn: (Serie series, _) => series.desempenho,
          measureFn: (Serie series, _) => series.qtd,
          colorFn: (Serie series, _) => series.barColor)
    ];

    return charts.PieChart<String>(series,
        animate: true,
        defaultRenderer:
            charts.ArcRendererConfig(arcWidth: 120, arcRendererDecorators: [
          charts.ArcLabelDecorator(
              insideLabelStyleSpec: const charts.TextStyleSpec(fontSize: 18),
              showLeaderLines: true, 
              )
        ]));
  }
}
