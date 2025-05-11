import 'package:flutter/material.dart';

class MutationScreen extends StatelessWidget {
  final List<String> mutations;

  MutationScreen({required this.mutations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mutasi Rekening'),
      ),
      body: mutations.isEmpty
          ? Center(
              child: Text(
                'Belum ada mutasi rekening.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: mutations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.history, color: Colors.blue),
                  title: Text(mutations[index]),
                );
              },
            ),
    );
  }
}