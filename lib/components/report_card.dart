import 'package:finan_reports/models/report.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class ReportCard extends StatelessWidget {
  final Report report;

  const ReportCard({
    Key? key,
    required this.report,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
          width: 350,
          margin:
              const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
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
                        )),
                    const Spacer(),
                    Text('${report.performance} desempenho',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: report.performance == 'Bom'
                                ? Colors.green
                                : report.performance == 'Médio'
                                    ? Colors.orangeAccent
                                    : Colors.red))
                  ],
                ),
                Row(
                  children: [
                    Text(DateFormat('MM/dd/yyyy').format(report.date),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(width: 30),
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
                    Text("${report.taxSelic}%",
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 30),
                    const Text('financiamento',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey)),
                    const SizedBox(width: 10),
                    Text("${report.taxFinan}%",
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                    height: 30,
                    color: Color.fromARGB(255, 194, 194, 194),
                    thickness: 2),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(report.description.toString()),
                )
              ],
            ),
          )),
    );
  }
}
