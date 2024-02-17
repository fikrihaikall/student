import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Nama Aplikasi: Data Mahasiswa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Versi: 1.0.0',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                'Daftar Nama:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildNameList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '© 2023 Kelompok 1',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildNameList() {
    List<String> names = ['Christin Gabriel Simanjuntak', 'Fikri Haikal', 'Muhammad Ikhsan Hilmi', 'Sopandi'];
    List<String> npm = ['21552011271', '21552011040', '22552012003', '19552011016'];

    List<Widget> listWidgets = [];

    for (int i = 0; i < names.length; i++) {
      listWidgets.addAll([
        Text('- ${names[i]}', style: TextStyle(fontSize: 16)),
        Text('- ${npm[i]}', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
      ]);
    }

    return Column(
      children: listWidgets,
    );
  }
}
