import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter_file_picker/flutter_file_picker.dart';
import 'package:fl_chart/fl_chart.dart';

void main() => runApp(LinearRegressionApp());

class LinearRegressionApp extends StatefulWidget {
  @override
  _LinearRegressionAppState createState() => _LinearRegressionAppState();
}

class _LinearRegressionAppState extends State<LinearRegressionApp> {
  List<List<dynamic>> csvData = [];
  double m = 0; // Slope (m) of the linear regression line
  double c = 0; // Y-intercept (c) of the linear regression line

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linear Regression App',
      theme: ThemeData(
        primaryColor: Colors.blue, // Set the primary color
        fontFamily: 'Roboto', // Set a custom font family
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Linear Regression App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20, // Increase the font size
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  // Open the file picker
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['csv'],
                  );

                  if (result != null) {
                    // Parse the CSV file
                    File file = File(result.files.single.path!);
                    String csvString = await file.readAsString();
                    csvData = CsvToListConverter().convert(csvString);
                    calculateLinearRegression();
                  }
                },
                child: Text(
                  'Upload CSV File',
                  style: TextStyle(
                    fontSize: 18, // Increase the font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Set the button background color
                ),
              ),
              SizedBox(height: 20),
              if (m != 0 || c != 0) // Show linear regression line if available
                Container(
                  height: 300,
                  width: 300,
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: 15,
                      minY: 0,
                      maxY: 50,
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: true),
                      gridData: FlGridData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, c),
                            FlSpot(15, m * 15 + c),
                          ],
                          isCurved: true,
                          colors: [Colors.blue],
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 20),
              Text(
                'Linear Regression:',
                style: TextStyle(
                  fontSize: 20, // Increase the font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'y = ${m.toStringAsFixed(2)}x + ${c.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18, // Increase the font size
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateLinearRegression() {
    int n = csvData.length;
    double sumX = 0, sumY = 0, sumXY = 0, sumXSquare = 0;

    for (int i = 1; i < n; i++) {
      double x = csvData[i][0];
      double y = csvData[i][1];
      sumX += x;
      sumY += y;
      sumXY += x * y;
      sumXSquare += x * x;
    }

    // Calculate the slope (m) and y-intercept (c) of the linear regression line
    m = (n * sumXY - sumX * sumY) / (n * sumXSquare - sumX * sumX);
    c = (sumY - m * sumX) / n;

    setState(() {});
  }
}
