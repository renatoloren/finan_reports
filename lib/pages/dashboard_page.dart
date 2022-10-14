import 'dart:convert';
import 'package:finan_reports/components/chart.dart';
import 'package:finan_reports/components/indicator_card.dart';
import 'package:finan_reports/components/line_charts.dart';
import 'package:finan_reports/models/indicator.dart';
import 'package:finan_reports/models/serie.dart';
import 'package:finan_reports/repository/report_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _reportRepository = ReportRepository();
  late Future<List> _futureReports;
  late Future<Indicator> selic;
  late Future<Indicator> finan;

  @override
  void initState() {
    loadReports();
    selic = fetchData(
        'https://api.bcb.gov.br/dados/serie/bcdata.sgs.11/dados/ultimos/2?formato=json');
    finan = fetchData(
        'https://api.bcb.gov.br/dados/serie/bcdata.sgs.20773/dados/ultimos/2?formato=json');
    super.initState();
  }

  void loadReports() async {
    _futureReports = _reportRepository.listReports();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const style = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 2);
    Column label(text) {
      return Column(
        children: [
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.topLeft,
            child: Text('$text', style: style),
          )
        ],
      );
    }

    return Scaffold(
        backgroundColor: const Color.fromRGBO(17, 18, 18, 1),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Olá, Renato',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Bem vindo ao seu Dashboard  :)',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600]),
                ),
              ),
              label('monitoração de variavies'),
              Row(
                children: [
                  FutureBuilder(
                      future: selic,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return IndicatorCard(
                              title: 'taxa selic',
                              value: snapshot.data!.value * 100,
                              change: snapshot.data!.change * 100);
                        } else if (snapshot.hasError) {
                          return IndicatorCard(
                              title: 'erro', value: 0.00, change: 0.00);
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      }),
                  FutureBuilder(
                      future: finan,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return IndicatorCard(
                              title: 'taxa financiamento',
                              value: snapshot.data!.value,
                              change: snapshot.data!.change);
                        } else if (snapshot.hasError) {
                          return IndicatorCard(
                              title: 'erro', value: 0.00, change: 0.00);
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      })
                ],
              ),
              label('desempenho e projeção de vendas'),
              LineCharts(),
              label('desempenho dos relatórios'),
              SizedBox(
                width: width,
                height: 250,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: const Color.fromRGBO(30, 31, 31, 1),
                    child: FutureBuilder(
                        future: _futureReports,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (!snapshot.data!.isNotEmpty) {
                              return const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Nenhum relatório cadastrado',
                                  style: style,
                                ),
                              );
                            }
                            return Chart(data: [
                              Serie(
                                  desempenho: 'bom',
                                  qtd: snapshot.data!
                                      .where((e) => e.performance == 'Bom')
                                      .length,
                                  barColor: charts.ColorUtil.fromDartColor(
                                      const Color.fromRGBO(60, 255, 178, 1))),
                              Serie(
                                  desempenho: 'ruim',
                                  qtd: snapshot.data!
                                      .where((e) => e.performance == 'Mal')
                                      .length,
                                  barColor: charts.ColorUtil.fromDartColor(
                                      Colors.red[600]!)),
                              Serie(
                                  desempenho: 'medio',
                                  qtd: snapshot.data!
                                      .where((e) => e.performance == 'Médio')
                                      .length,
                                  barColor: charts.ColorUtil.fromDartColor(
                                      Colors.orangeAccent))
                            ]);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        })),
              ),
            ],
          ),
        ));
  }
}

Future<Indicator> fetchData(url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final List parsedList = await jsonDecode(response.body);
    return Indicator(
        value: double.parse(parsedList.elementAt(1)['valor']),
        change: double.parse(parsedList.elementAt(1)['valor']) -
            double.parse(parsedList.elementAt(0)['valor']));
  } else {
    throw Exception('Failed to load finan');
  }
}
