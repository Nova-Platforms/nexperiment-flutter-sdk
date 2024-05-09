import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nexperiment/nexperiment.dart';

class SalaryCalculator extends StatefulWidget {
  final Nexperiment nexperimentSDK;

  const SalaryCalculator({super.key, required this.nexperimentSDK});

  @override
  _SalaryCalculatorState createState() => _SalaryCalculatorState();
}

class _SalaryCalculatorState extends State<SalaryCalculator> {
  late Nexperiment _nexperimentSDK;

  late TaxTable taxTable;

  double salary = 0.0;
  double inss = 0.0;
  double irpf = 0.0;
  double netSalary = 0.0;

  @override
  void initState() {
    _nexperimentSDK = widget.nexperimentSDK;

    _nexperimentSDK.getConfig("br-worker-salary-discount").then((config) {
      taxTable = TaxTable.fromJson(config.value);
    });

    super.initState();
  }

  double calculateINSS(double salary) {
    var inssTaxes = taxTable.inssTaxes.firstWhere((tax) => tax.salario_ate >= salary);
    return (salary * inssTaxes.percentual) + inssTaxes.desconto_fixo;
  }

  double calculateIRPF(double salary) {
    var irpfTaxes = taxTable.irpfTaxes.firstWhere((tax) => tax.salario_ate >= salary);
    return (salary * irpfTaxes.percentual) + irpfTaxes.desconto_fixo;
  }

  void calculateNetSalary(double salary) {
    setState(() {
      inss = calculateINSS(salary);
      irpf = calculateIRPF(salary);
      netSalary = salary - inss - irpf;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Salary Calculator',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'My Salary'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  salary = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                calculateNetSalary(salary);
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Brazil Salary Discounts',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            const Divider(),
            const SizedBox(height: 16.0),
            Text(
              'INSS: R\$ ${inss.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'IRPF: R\$ ${irpf.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Result: R\$ ${netSalary.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tax<T> {
  final double percentual;
  final double salario_ate;
  final double desconto_fixo;

  Tax({
    required this.percentual,
    required this.salario_ate,
    required this.desconto_fixo,
  });

  factory Tax.fromJson(Map<String, dynamic> json) {
    return Tax(
      percentual: json['percentual'].toDouble() / 100,
      salario_ate: json['salario_ate'].toDouble(),
      desconto_fixo: json['desconto_fixo'].toDouble(),
    );
  }
}

class TaxTable {
  final List<Tax> inssTaxes;
  final List<Tax> irpfTaxes;

  TaxTable({required this.inssTaxes, required this.irpfTaxes});

  factory TaxTable.fromJson(Map<String, dynamic> json) {
    List<dynamic> inssJson = json['inss'];
    List<dynamic> irpfJson = json['irpf'];

    List<Tax> inssTaxes = inssJson.map((data) => Tax.fromJson(data)).toList();
    List<Tax> irpfTaxes = irpfJson.map((data) => Tax.fromJson(data)).toList();

    return TaxTable(inssTaxes: inssTaxes, irpfTaxes: irpfTaxes);
  }
}
