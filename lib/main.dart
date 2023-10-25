import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:final_640710138/sceens/home/home_page.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Text('Bangkok', style: TextStyle(color: Colors.black)),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Text('Nakhon Pathom', style: TextStyle(color: Colors.black)),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Text('Paris', style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FutureBuilder<List<String>>(
                future: fetchDataFromAPI('https://cpsu-test-api.herokuapp.com/api/1_2566/weather/current?city=bangkok'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('ERROR: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data?[index] ?? 'null'),
                        );
                      },
                    );
                  }
                },
              ),

              FutureBuilder<List<String>>(
                future: fetchDataFromAPI('https://cpsu-test-api.herokuapp.com/api/1_2566/weather/current?city=nakhon pathom'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('ERROR: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data?[index] ?? 'null'),
                        );
                      },
                    );
                  }
                },
              ),

              FutureBuilder<List<String>>(
                future: fetchDataFromAPI('https://cpsu-test-api.herokuapp.com/api/1_2566/weather/current?city=paris'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('ERROR: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data?[index] ?? 'null'),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>> fetchDataFromAPI(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['items'] != null) {
        final List<dynamic> items = data['items'];
        return items.map((item) => item.toString()).toList();
      }
    }

    throw Exception('ไม่สามารถดึงข้อมูลได้');
  }

}