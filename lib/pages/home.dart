import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_expenses/models/invoice.dart';

Future<List<Invoice>> fetchFuture() async {
  final response = await http.get(Uri.parse('http://localhost:3000/invoices'));
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((albumJson) => Invoice.fromJson(albumJson)).toList();
  } else {
    throw Exception('Failed to load albums');
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<List<Invoice>> futureInvoices;

  @override
  void initState() {
    super.initState();
    futureInvoices = fetchFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Invoice>>(
        future: futureInvoices,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 10,
                      margin: const EdgeInsets.all(10),
                      child: Column(children: [
                        Image.network(
                          snapshot.data![index].image,
                          fit: BoxFit.cover,
                        )
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 10),
                      child: Row(children: [
                        Text(
                          snapshot.data![index].description.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          snapshot.data![index].date.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w100,
                          ),
                        )
                      ]),
                    )
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
