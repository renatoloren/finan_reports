import 'package:finan_reports/database/database_manager.dart';
import 'package:finan_reports/models/report.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ReportRepository {
  Future<List<Report>> listReports() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
    SELECT 
      reports.id, 
      reports.title,
      reports.date,
      reports.taxFinan, 
      reports.taxSelic, 
      reports.performance,
      reports.description
    FROM reports
''');
    return rows
        .map((r) => Report(
            id: r['id'],
            title: r['title'],
            date: DateTime.fromMillisecondsSinceEpoch(r['date']),
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
      "date": report.date.millisecondsSinceEpoch,
      "taxSelic": report.taxSelic,
      "taxFinan": report.taxFinan,
      "performance": report.performance,
      "description": report.description
    });
  }

  Future<void> deleteReport(int id) async {
    final db = await DatabaseManager().getDatabase();
    await db.delete('reports', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> editReport(Report report) async {
    final db = await DatabaseManager().getDatabase();

    db.update(
        "reports",
        {
          "title": report.title,
          "date": report.date.millisecondsSinceEpoch,
          "taxSelic": report.taxSelic,
          "taxFinan": report.taxFinan,
          "performance": report.performance,
          "description": report.description
        },
        where: 'id = ?',
        whereArgs: [report.id]);
  }

  Future<List> toChartData() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
    SELECT 
      reports.id, 
      reports.title,
      reports.date,
      reports.taxFinan, 
      reports.taxSelic, 
      reports.performance,
      reports.description
    FROM reports
''');
    final reports = rows
        .map((r) => Report(
            id: r['id'],
            title: r['title'],
            date: DateTime.fromMillisecondsSinceEpoch(r['date']),
            taxFinan: r['taxFinan'],
            taxSelic: r['taxSelic'],
            performance: r['performance'],
            description: r['description']))
        .toList();

    final boas = reports.where((e) => e.performance == 'bom');
    final medias = reports.where((e) => e.performance == 'Médio');
    final ruins = reports.where((e) => e.performance == 'Mal');

    return [boas, medias, ruins].toList();
  }
}
