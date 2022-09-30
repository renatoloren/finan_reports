import 'package:finan_reports/database/database_manager.dart';
import 'package:finan_reports/models/report.dart';

class ReportRepository {
  Future<List<Report>> listReports() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
    SELECT * FROM reports
''');
    print(rows);
    return rows
        .map((r) => Report(
            id: r['id'],
            title: r['title'],
            date: r['date'],
            taxFinan: r['t_finan'],
            taxSelic: r['t_selic'],
            performance: r['performance'],
            description: r['description']))
        .toList();
  }

  Future<void> registryReport(Report report) async {
    final db = await DatabaseManager().getDatabase();

    db.insert("reports", {
      "title": report.title,
      "date": report.date,
      "t_selic": report.taxSelic,
      "t_finan": report.taxFinan,
      "performance": report.performance,
      "description": report.description
    });
  }
}
