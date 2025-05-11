import 'package:flutter/material.dart';

class CheckBalanceScreen extends StatelessWidget {
  final double saldo;

  CheckBalanceScreen({required this.saldo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cek Saldo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Saldo Anda Saat Ini',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Text(
                'Rp. ${saldo.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Kembali ke Menu Utama'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}