import 'package:finan_reports/models/report.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportCard extends StatelessWidget {
  final Report report;
  final Function() onDelete;
  final Function() onEdit;
  ReportCard(
      {Key? key,
      required this.report,
      required this.onDelete,
      required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
          width: 350,
          margin:
              const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
          padding:
              const EdgeInsets.only(left: 30, top: 20, right: 20, bottom: 20),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(30, 31, 31, 1),
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
                            color: Colors.white)),
                    const Spacer(),
                    PopupMenuButton(
                        icon: const Icon(Icons.more_horiz, color: Colors.white),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                              PopupMenuItem(
                                onTap: onDelete,
                                child: const Text('Excluir'),
                              ),
                              PopupMenuItem(
                                onTap: onEdit,
                                child: const Text('Editar'),
                              )
                            ])
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(DateFormat('MM/dd/yyyy').format(report.date),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(width: 10),
                    Text('${report.performance} desempenho',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: report.performance == 'Bom'
                                ? const Color.fromRGBO(60, 255, 178, 1)
                                : report.performance == 'Médio'
                                    ? Colors.orangeAccent
                                    : Colors.red[600])),
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
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white)),
                    const SizedBox(width: 30),
                    const Text('financiamento',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey)),
                    const SizedBox(width: 10),
                    Text("${report.taxFinan}%",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                    height: 30,
                    color: Color.fromARGB(255, 194, 194, 194),
                    thickness: 2),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(report.description.toString(),
                      style: const TextStyle(color: Colors.white)),
                )
              ],
            ),
          )),
    );
  }
}
