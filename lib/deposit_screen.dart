import 'package:flutter/material.dart';

class DepositScreen extends StatefulWidget {
  final Function(double) onDeposit;

  DepositScreen({required this.onDeposit});

  @override
  _DepositScreenState createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
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

  void _confirmDeposit(double amount) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Deposito'),
          content: Text(
            'Apakah Anda yakin ingin mendepositkan Rp. ${amount.toStringAsFixed(2)}?',
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
                widget.onDeposit(amount); // Lakukan deposit
                Navigator.pop(context); // Tutup dialog konfirmasi
                _showSuccessDialog('Deposito sebesar Rp. ${amount.toStringAsFixed(2)} berhasil.');
              },
              child: Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  void _handleDeposit() {
    final amount = double.tryParse(_amountController.text);
    if (amount != null && amount > 0) {
      _confirmDeposit(amount); // Tampilkan dialog konfirmasi
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Masukkan jumlah deposito yang valid')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deposito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan jumlah deposito:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Jumlah Deposito',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleDeposit,
              child: Text('Deposit'),
            ),
          ],
        ),
      ),
    );
  }
}