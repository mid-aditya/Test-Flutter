import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AgendaTab extends StatefulWidget {
  const AgendaTab({Key? key}) : super(key: key);

  @override
  _AgendaTabState createState() => _AgendaTabState();
}

class _AgendaTabState extends State<AgendaTab> {
  late Future<List<dynamic>> _agendaList;

  @override
  void initState() {
    super.initState();
    _agendaList = fetchAgenda();
  }

  Future<List<dynamic>> fetchAgenda() async {
    try {
      final response = await http.get(
          Uri.parse('https://praktikum-cpanel-unbin.com/API_praktikum_TEGARRR/agenda.php'));

      // Print the raw response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // Check the structure of the data
        print('Fetched data: $data');
        return data;
      } else {
        throw Exception('Failed to load agenda');
      }
    } catch (e) {
      // Handle any errors during the request
      print('Error fetching agenda: $e');
      throw Exception('Failed to load agenda');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _agendaList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No agenda available'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final agendaItem = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        agendaItem['judul_agenda'] ?? 'No Title',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        agendaItem['isi_agenda'] ?? 'No Content',
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Date: ${agendaItem['tgl_agenda'] ?? 'No Date'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
