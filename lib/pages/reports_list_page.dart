import 'package:finan_reports/components/report_card.dart';
import 'package:finan_reports/models/report.dart';
import 'package:finan_reports/pages/report_cadastro_page.dart';
import 'package:finan_reports/repository/report_repository.dart';
import 'package:flutter/material.dart';

class ReportsListPage extends StatefulWidget {
  const ReportsListPage({Key? key}) : super(key: key);

  @override
  State<ReportsListPage> createState() => _ReportsListPageState();
}

class _ReportsListPageState extends State<ReportsListPage> {
  final _reportRepository = ReportRepository();
  late Future<List<Report>> _futureReports;

  @override
  void initState() {
    loadReports();
    super.initState();
  }

  void loadReports() {
    _futureReports = _reportRepository.listReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(17, 18, 18, 1),
      appBar: AppBar(
        title: const Text('Relatórios de Desempenhos'),
        backgroundColor: const Color.fromRGBO(17, 18, 18, 1),
      ),
      body: FutureBuilder<List<Report>>(
        future: _futureReports,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final reports = snapshot.data ?? [];
            return ListView.separated(
              itemCount: reports.length,
              separatorBuilder: (context, index) => const SizedBox(height: 0),
              itemBuilder: (context, index) {
                final report = reports[index];
                return ReportCard(
                    report: report,
                    onDelete: (() async {
                      await _reportRepository.deleteReport(report.id!);

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Relatório excluído com sucesso')));
                      setState(() {
                        reports.removeAt(index);
                      });
                    }),
                    onEdit: (() async {
                      final navigator = Navigator.of(context);
                      await Future.delayed(Duration.zero);
                      var success = await navigator.push(
                        MaterialPageRoute(
                            builder: (_) => ReportCadastroPage(
                                  reportParaEdicao: report,
                                )),
                      );

                      if (success != null && success) {
                        setState(() {
                          loadReports();
                        });
                      }
                    }));
              },
            );
          }
          return Container();
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? reportCadastrado = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReportCadastroPage()),
          );
          if (reportCadastrado != null && reportCadastrado) {
            setState(() {
              loadReports();
            });
          }
        },
        tooltip: 'Increment',
        backgroundColor: const Color.fromRGBO(60, 255, 178, 1),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
