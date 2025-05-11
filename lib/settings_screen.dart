import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text('Profil'),
              subtitle: Text('Kelola informasi profil Anda'),
              onTap: () {
                // Tambahkan navigasi ke halaman profil jika diperlukan
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.blue),
              title: Text('Keamanan'),
              subtitle: Text('Ubah kata sandi atau pengaturan keamanan'),
              onTap: () {
                // Tambahkan navigasi ke halaman keamanan jika diperlukan
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.blue),
              title: Text('Notifikasi'),
              subtitle: Text('Kelola preferensi notifikasi'),
              onTap: () {
                // Tambahkan navigasi ke halaman notifikasi jika diperlukan
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info, color: Colors.blue),
              title: Text('Tentang Aplikasi'),
              subtitle: Text('Informasi tentang aplikasi ini'),
              onTap: () {
                // Tambahkan navigasi ke halaman tentang aplikasi jika diperlukan
              },
            ),
          ],
        ),
      ),
    );
  }
}