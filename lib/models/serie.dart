import 'package:charts_flutter/flutter.dart' as charts;

class Serie {
  final String desempenho;
  final int qtd;
  final charts.Color barColor;

  Serie({required this.desempenho, required this.qtd, required this.barColor});
}
