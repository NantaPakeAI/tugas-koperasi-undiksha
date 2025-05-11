import 'package:flutter/material.dart';
import 'transfer_screen.dart';
import 'check_balance_screen.dart';
import 'mutation_screen.dart';
import 'deposit_screen.dart';
import 'payment_screen.dart';
import 'loan_screen.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_screen.dart'; // Tambahkan impor ini
import 'profile_screen.dart'; // Tambahkan impor ini

class MainMenuScreen extends StatefulWidget {
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  double _saldo = 1000;
  List<String> _mutations = [];

  void _handleTransfer(double amount) {
    setState(() {
      _saldo -= amount;
      _mutations.add('Transfer sebesar Rp. ${amount.toStringAsFixed(2)} berhasil.');
    });
  }

  void _handleDeposit(double amount) {
    setState(() {
      _saldo += amount;
      _mutations.add('Deposito sebesar Rp. ${amount.toStringAsFixed(2)} berhasil.');
    });
  }

  void _handlePayment(String billType, double amount) {
    setState(() {
      _saldo -= amount;
      _mutations.add('Pembayaran $billType sebesar Rp. ${amount.toStringAsFixed(2)} berhasil.');
    });
  }

  void _handleLoan(double amount) {
    setState(() {
      _saldo += amount;
      _mutations.add('Pinjaman sebesar Rp. ${amount.toStringAsFixed(2)} berhasil.');
    });
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Hapus status login

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Utama'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0), // Geser tombol ke bawah
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: _logout, // Panggil fungsi logout
              tooltip: 'Log Out',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Section
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nasabah',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      'I Komang Ananta Mahayana',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Total Saldo Anda',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      'Rp. ${_saldo.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32),
            // Action Buttons Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuButton(context, 'Cek Saldo', Icons.account_balance_wallet, onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckBalanceScreen(saldo: _saldo),
                      ),
                    );
                  }),
                  _buildMenuButton(context, 'Transfer', Icons.arrow_upward, onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransferScreen(onTransfer: _handleTransfer),
                      ),
                    );
                  }),
                  _buildMenuButton(context, 'Mutasi', Icons.history, onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MutationScreen(mutations: _mutations),
                      ),
                    );
                  }),
                  _buildMenuButton(context, 'Deposito', Icons.account_balance, onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DepositScreen(onDeposit: _handleDeposit),
                      ),
                    );
                  }),
                  _buildMenuButton(context, 'Pembayaran', Icons.payment, onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(onPayment: _handlePayment),
                      ),
                    );
                  }),
                  _buildMenuButton(context, 'Pinjaman', Icons.monetization_on, onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoanScreen(onLoan: _handleLoan),
                      ),
                    );
                  }),
                ],
              ),
            ),
            // Help Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Butuh Bantuan?\n081234567890',
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.phone, color: Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey, // Warna untuk item yang dipilih
        unselectedItemColor: Colors.grey, // Warna untuk item yang tidak dipilih
        showSelectedLabels: true, // Tampilkan label untuk item yang dipilih
        showUnselectedLabels: true, // Tampilkan label untuk item yang tidak dipilih
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          }
          // Tambahkan navigasi untuk item lainnya jika diperlukan
        },
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, IconData icon, {VoidCallback? onTap}) {
    return ElevatedButton(
      onPressed: onTap ?? () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}