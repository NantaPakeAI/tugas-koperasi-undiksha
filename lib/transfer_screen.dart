import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  final Function(double) onTransfer;

  TransferScreen({required this.onTransfer});

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _accountNumberController = TextEditingController();
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

  void _confirmTransfer(double amount, String accountNumber) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Transfer'),
          content: Text(
            'Apakah Anda yakin ingin mentransfer Rp. ${amount.toStringAsFixed(2)} ke rekening $accountNumber?',
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
                widget.onTransfer(amount); // Lakukan transfer
                Navigator.pop(context); // Tutup dialog
                _showSuccessDialog(
                  'Transfer sebesar Rp. ${amount.toStringAsFixed(2)} ke rekening $accountNumber berhasil.',
                ); // Tampilkan dialog sukses
              },
              child: Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _accountNumberController,
              decoration: InputDecoration(
                labelText: 'Nomor Rekening',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Jumlah Transfer',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final accountNumber = _accountNumberController.text;
                final amount = double.tryParse(_amountController.text);

                if (accountNumber.isNotEmpty && amount != null && amount > 0) {
                  _confirmTransfer(amount, accountNumber); // Tampilkan dialog konfirmasi
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Masukkan nomor rekening dan jumlah transfer yang valid')),
                  );
                }
              },
              child: Text('Transfer'),
            ),
          ],
        ),
      ),
    );
  }
}