import 'dart:ffi';

import 'package:finan_reports/components/report_card.dart';
import 'package:finan_reports/models/report.dart';
import 'package:finan_reports/repository/report_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

class ReportCadastroPage extends StatefulWidget {
  Report? reportParaEdicao;
  ReportCadastroPage({Key? key, this.reportParaEdicao}) : super(key: key);

  @override
  State<ReportCadastroPage> createState() => _ReportCadastroPageState();
}

class _ReportCadastroPageState extends State<ReportCadastroPage> {
  ReportRepository _reportRepository = ReportRepository();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _taxSelicController =
      MoneyMaskedTextController(decimalSeparator: ','); //ver input de number
  final _taxFinanController =
      MoneyMaskedTextController(decimalSeparator: ','); //ver input de number
  final _performanceController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<String> listPerformance = <String>['Bom', 'Médio', 'Mal'];
  String dropdownValue = 'Bom';

  @override
  void initState() {
    super.initState();

    final report = widget.reportParaEdicao;
    if (report != null) {
      _titleController.text = report.title;
      //_dateController.text = DateFormat('MM/dd/yyyy').format(report.date);
      _taxSelicController.text = report.taxSelic!.toDouble() as String;
      _taxFinanController.text = report.taxFinan!.toDouble() as String;
      _performanceController.text = report.performance;
      _descriptionController.text = report.description!;
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Relatório'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildTitle(),
                const SizedBox(height: 20),
                _buildDate(),
                const SizedBox(height: 20),
                _buildTaxSelic(),
                const SizedBox(height: 20),
                _buildTaxFinan(),
                const SizedBox(height: 20),
                _buildPerformance(),
                const SizedBox(height: 20),
                _buildDescription(),
                const SizedBox(height: 20),
                _buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildTitle() {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        hintText: 'Informe o Título',
        labelText: 'Título do Relatório',
        filled: true,
        fillColor: Color.fromARGB(255, 218, 218, 218),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.auto_graph),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um Título';
        }
        if (value.length < 5 || value.length > 30) {
          return 'O título deve entre 4 e 30 caracteres';
        }
        return null;
      },
    );
  }

  TextFormField _buildTaxSelic() {
    return TextFormField(
      controller: _taxSelicController,
      decoration: InputDecoration(
        hintText: 'Informe o valor da taxa selic',
        labelText: 'Valor taxa selic',
        filled: true,
        fillColor: Color.fromARGB(255, 218, 218, 218),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.percent),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um Valor para a taxa selic';
        }

        return null;
      },
    );
  }

  TextFormField _buildTaxFinan() {
    return TextFormField(
      controller: _taxFinanController,
      decoration: InputDecoration(
        hintText: 'Informe o valor da taxa de financiamento',
        labelText: 'Valor taxa financiamento',
        filled: true,
        fillColor: Color.fromARGB(255, 218, 218, 218),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.percent),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um Valor para a taxa de financiamento';
        }

        return null;
      },
    );
  }

  DropdownButtonFormField _buildPerformance() {
    return DropdownButtonFormField<String>(
      value: dropdownValue,
      items: listPerformance.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      decoration: InputDecoration(
        hintText: 'Selecione o desempenho',
        labelText: 'Desempenho',
        filled: true,
        fillColor: Color.fromARGB(255, 218, 218, 218),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.dashboard),
      ),
      validator: (value) {
        if (value == null) {
          return 'Informe um desempenho';
        }
        return null;
      },
    );
  }

  TextFormField _buildDescription() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        hintText: 'Escreve uma descrição',
        labelText: 'Descrição',
        filled: true,
        fillColor: Color.fromARGB(255, 218, 218, 218),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 2,
    );
  }

  SizedBox _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Cadastrar'),
        ),
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            final title = _titleController.text;
            final taxSelic = double.parse(_taxSelicController.text
                .replaceAll('.', '')
                .replaceAll(',', '.'));
            final taxFinan = double.parse(_taxFinanController.text
                .replaceAll('.', '')
                .replaceAll(',', '.'));
            final performance = dropdownValue;
            final description = _descriptionController.text;
            final date = DateFormat('dd/MM/yyyy').parse(_dateController.text);

            final report = Report(
              title: title,
              // date: DateTime.now().toString(),
              date: date,
              taxSelic: taxSelic,
              taxFinan: taxFinan,
              performance: performance,
              description: description,
            );

            try {
              // if (widget.reportParaEdicao != null) {
              //   report.id = widget.reportParaEdicao!.id;
              //   await _reportRepository.editarReport(report);
              // } else {
              await _reportRepository.registryReport(report);
              // }

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Report cadastrado com sucesso'),
              ));
              Navigator.of(context).pop(true);
            } catch (e) {
              Navigator.of(context).pop(false);
            }
          }
        },
      ),
    );
  }

  TextFormField _buildDate() {
    return TextFormField(
      controller: _dateController,
      decoration: InputDecoration(
        hintText: 'Informe uma Data',
        labelText: 'Data',
        filled: true,
        fillColor: Color.fromARGB(255, 218, 218, 218),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.calendar_month),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        DateTime? dataSelecionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (dataSelecionada != null) {
          _dateController.text =
              DateFormat('dd/MM/yyyy').format(dataSelecionada);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma Data';
        }

        try {
          DateFormat('dd/MM/yyyy').parse(value);
        } on FormatException {
          return 'Formato de data inválida';
        }

        return null;
      },
    );
  }
}
