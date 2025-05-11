import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final Function(String, double) onPayment;

  PaymentScreen({required this.onPayment});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _billTypeController = TextEditingController();
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

  void _confirmPayment(String billType, double amount) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembayaran'),
          content: Text(
            'Apakah Anda yakin ingin membayar $billType sebesar Rp. ${amount.toStringAsFixed(2)}?',
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
                widget.onPayment(billType, amount); // Lakukan pembayaran
                Navigator.pop(context); // Tutup dialog konfirmasi
                _showSuccessDialog('Pembayaran $billType sebesar Rp. ${amount.toStringAsFixed(2)} berhasil.');
              },
              child: Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  void _handlePayment() {
    final billType = _billTypeController.text;
    final amount = double.tryParse(_amountController.text);

    if (billType.isNotEmpty && amount != null && amount > 0) {
      _confirmPayment(billType, amount); // Tampilkan dialog konfirmasi
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Masukkan jenis tagihan dan jumlah pembayaran yang valid')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis Tagihan:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _billTypeController,
              decoration: InputDecoration(
                labelText: 'Jenis Tagihan (contoh: Listrik, Air, dll)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Jumlah Pembayaran:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Jumlah Pembayaran',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handlePayment,
              child: Text('Bayar'),
            ),
          ],
        ),
      ),
    );
  }
}