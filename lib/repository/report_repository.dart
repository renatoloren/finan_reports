import 'package:finan_reports/database/database_manager.dart';
import 'package:finan_reports/models/report.dart';

class ReportRepository {
  Future<List<Report>> listReports() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
    SELECT * FROM reports
''');
    return rows
        .map((r) => Report(
            id: r['id'],
            title: r['title'],
            date: r['date'],
            taxFinan: r['taxFinan'],
            taxSelic: r['taxSelic'],
            performance: r['performance'],
            description: r['description']))
        .toList();
  }

  Future<void> registryReport(Report report) async {
    final db = await DatabaseManager().getDatabase();

    db.insert("reports", {
      "title": report.title,
      "date": report.date,
      "taxSelic": report.taxSelic,
      "taxFinan": report.taxFinan,
      "performance": report.performance,
      "description": report.description
    });
  }
}
