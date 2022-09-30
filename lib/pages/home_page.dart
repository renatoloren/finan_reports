import 'package:finan_reports/components/report_card.dart';
import 'package:finan_reports/models/report.dart';
import 'package:finan_reports/repository/report_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      appBar: AppBar(
        title: const Text('teste'),
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
            return ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];
                return ReportCard(report: report);
              },
            );
          }
          return Container();
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => loadReports()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
