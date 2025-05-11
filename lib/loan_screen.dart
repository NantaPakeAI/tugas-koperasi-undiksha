import 'package:flutter/material.dart';

class LoanScreen extends StatefulWidget {
  final Function(double) onLoan;

  LoanScreen({required this.onLoan});

  @override
  _LoanScreenState createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  final TextEditingController _amountController = TextEditingController();

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Berhasil'),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _confirmLoan(double amount) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Pinjaman'),
          content: Text(
            'Apakah Anda yakin ingin mengajukan pinjaman sebesar Rp. ${amount.toStringAsFixed(2)}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onLoan(amount); // Lakukan pinjaman
                Navigator.pop(context); // Tutup dialog konfirmasi
                _showSuccessDialog('Pinjaman sebesar Rp. ${amount.toStringAsFixed(2)} berhasil.');
              },
              child: Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  void _handleLoan() {
    final amount = double.tryParse(_amountController.text);

    if (amount != null && amount > 0) {
      _confirmLoan(amount); // Tampilkan dialog konfirmasi
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Masukkan jumlah pinjaman yang valid')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pinjaman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan jumlah pinjaman:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Jumlah Pinjaman',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleLoan,
              child: Text('Ajukan Pinjaman'),
            ),
          ],
        ),
      ),
    );
  }
}