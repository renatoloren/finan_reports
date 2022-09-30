class Report {
  int? id;
  String title;
  DateTime date;
  double? taxSelic;
  double? taxFinan;
  int performance;
  String? description;

  Report(
      {this.id,
      required this.title,
      required this.date,
      this.taxSelic,
      this.taxFinan,
      required this.performance,
      this.description = ''});
}
