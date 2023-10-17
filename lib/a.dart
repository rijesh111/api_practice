import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ApiEntry {
  final String api;
  final String description;
  final String category;

  ApiEntry({
    required this.api,
    required this.description,
    required this.category,
  });

  factory ApiEntry.fromJson(Map<String, dynamic> json) {
    return ApiEntry(
      api: json['API'] as String,
      description: json['Description'] as String,
      category: json['Category'] as String,
    );
  }
}

class ApiPractice1 extends StatefulWidget {
  const ApiPractice1({Key? key}) : super(key: key);

  @override
  State<ApiPractice1> createState() => _ApiPractice1State();
}

class _ApiPractice1State extends State<ApiPractice1> {
  List<ApiEntry> apiData = [];

  Future<void> fetchData() async {
    try {
      final dio = Dio();
      final res = await dio.get("https://api.publicapis.org/entries");
      final List<dynamic> apiEntriesJson = res.data['entries'];

      setState(() {
        apiData =
            apiEntriesJson.map((entry) => ApiEntry.fromJson(entry)).toList();
      });
    } catch (err) {
      print('Error: $err');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Practice"),
      ),
      body: apiData.isEmpty
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: apiData.length,
              itemBuilder: (context, index) {
                final entry = apiData[index];
                return Container(
                  color: const Color.fromARGB(255, 18, 160, 160),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NewText(entry: entry.api),
                      Text(entry.description),
                      Text(
                        entry.category,
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class NewText extends StatelessWidget {
  const NewText({
    Key? key,
    required this.entry,
  }) : super(key: key);

  final String entry;

  @override
  Widget build(BuildContext context) {
    return Text(
      entry,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
