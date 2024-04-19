import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StatisticsPage extends StatelessWidget {
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> fetchStatistics() async {
    final String? token = await storage.read(key: 'token');
    var url = Uri.parse(
        'http://192.168.0.193/games/stats'); // Replace with actual endpoint
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
        title: Text(
          "Statistics",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Statistic')),
                      DataColumn(label: Text('Value')),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('Total Games')),
                        DataCell(Text('${stats["total_games"]}')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Games Won')),
                        DataCell(Text('${stats["games_won"]}')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Games Lost')),
                        DataCell(Text('${stats["games_lost"]}')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Games vs Bot')),
                        DataCell(Text('${stats["games_vs_bot"]}')),
                      ]),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
