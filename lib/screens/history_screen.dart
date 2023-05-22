import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore.collection('history').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return const Text("Error occurred while loading history.");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final historyDocs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: historyDocs.length,
              itemBuilder: (context, index) {
                final historyData = historyDocs[index].data();
                final calculation = historyData['calculation'];
                final time = historyData['timestamp'];

                return ListTile(
                  title: Text(calculation),
                  subtitle: Text(time),
                );
              },
            );
          }

          return const Text("No history records found.");
        },
      ),
    );
  }
}
