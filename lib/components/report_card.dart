import 'package:finan_reports/models/report.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  // final Report report;
  final Report report;

  const ReportCard({
    Key? key,
    required this.report,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var perc = '12.90';
    return SizedBox(
      child: Container(
          width: 350,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0), width: 2)),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(report.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ))
                  ],
                ),
                Row(
                  children: [
                    Text(report.date.toString(),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(width: 30),
                    Text(report.performance.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green))
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text('selic',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey)),
                    const SizedBox(width: 10),
                    Text('$perc%', style: const TextStyle(fontSize: 16)),
                    const Spacer(),
                    const Text('financiamento',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey)),
                    const SizedBox(width: 10),
                    Text('$perc%', style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                    'teaasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf')
              ],
            ),
          )),
    );
  }
}
