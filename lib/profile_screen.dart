import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile.jpg'), // Ganti dengan path gambar profil Anda
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                'I Komang Ananta Mahayana',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 32),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text('Email'),
              subtitle: Text('ananta.mahayana@student.undiksha.ac.id'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blue),
              title: Text('Nomor Telepon'),
              subtitle: Text('081234567890'),
            ),
          ],
        ),
      ),
    );
  }
}