import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ApiPractice extends StatefulWidget {
  const ApiPractice({super.key});

  @override
  State<ApiPractice> createState() => _ApiPracticeState();
}

class _ApiPracticeState extends State<ApiPractice> {
  List<dynamic> apiData = [];

  Future<void> fetchData() async {
    try {
      final dio = Dio();
      final res = await dio.get("https://api.publicapis.org/entries");
      setState(() {
        apiData = res.data['entries'];
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
  Widget build(context) {
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
                      NewText(entry: entry['API']),
                      Text(entry['Description']),
                      Text(
                        entry['Category'],
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
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
    super.key,
    required this.entry,
  });

  final String entry;

  @override
  Widget build(BuildContext context) {
    return Text(
      entry,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
