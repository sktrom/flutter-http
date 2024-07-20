import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Api'),
      ),
      body: ListView(
        children: [
          Container(
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () async {
                isLoading = true;
                setState(() {});
                String uri = 'https://jsonplaceholder.typicode.com/posts';
                var response = await get(Uri.parse(uri));
                List responseBody = jsonDecode(response.body);

                data.addAll(responseBody);
                isLoading = false;
                setState(() {});

                // log(responseBody[1]['title'].toString());
                // log(response.statusCode.toString());
              },
              child: const Text('Http Request'),
            ),
          ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
          ...List.generate(
            data.length,
            (index) => Card(
              child: ListTile(
                title: Text("Title: ${data[index]['title']}"),
                subtitle: Text("${data[index]['body']}"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
