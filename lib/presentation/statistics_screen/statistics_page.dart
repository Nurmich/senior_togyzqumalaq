import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/app_export.dart';

class StatisticsPage extends StatelessWidget {
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> fetchStatistics() async {
    final String? token = await storage.read(key: 'token');
    var url = Uri.parse(
        'http://192.168.0.117/games/stats'); // Replace with actual endpoint
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer $token', // Use 'Token $token' if required by your backend
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      // Handle the error; maybe throw an error or return default data
      throw Exception('Failed to load statistics');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        title: Center(
          child: Text(
            "Statistics",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFC57941),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchStatistics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var stats = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 200),
                  Card(
                    elevation: 4,
                    color:
                        Colors.blueGrey[50], // Change the background color here
                    child: Container(
                      decoration: AppDecoration.gradientOrangeAToRed.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder12,
                      ),
                      child: DataTable(
                        columnSpacing: 20,
                        columns: [
                          DataColumn(
                            label: Text(
                              'Statistic',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Value',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(
                              Text(
                                'Total Games',
                                style: TextStyle(
                                    color: Colors
                                        .white), // Set text color to white
                              ),
                            ),
                            DataCell(
                              Text(
                                '${stats["total_games"]}',
                                style: TextStyle(
                                    color: Colors
                                        .white), // Set text color to white
                              ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(
                              Text(
                                'Games Won',
                                style: TextStyle(
                                    color: Colors
                                        .white), // Set text color to white
                              ),
                            ),
                            DataCell(
                              Text(
                                '${stats["games_won"]}',
                                style: TextStyle(
                                    color: Colors
                                        .white), // Set text color to white
                              ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(
                              Text(
                                'Games Lost',
                                style: TextStyle(
                                    color: Colors
                                        .white), // Set text color to white
                              ),
                            ),
                            DataCell(
                              Text(
                                '${stats["games_lost"]}',
                                style: TextStyle(
                                    color: Colors
                                        .white), // Set text color to white
                              ),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(
                              Text(
                                'Games vs Bot',
                                style: TextStyle(
                                    color: Colors
                                        .white), // Set text color to white
                              ),
                            ),
                            DataCell(
                              Text(
                                '${stats["games_vs_bot"]}',
                                style: TextStyle(
                                    color: Colors
                                        .white), // Set text color to white
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
