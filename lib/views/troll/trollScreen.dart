import 'package:flutter/material.dart';
import 'package:morfo/provider/tambahTroll_provider.dart';
import 'package:morfo/provider/theme_provider.dart';
import 'package:morfo/views/home/HomeScreen.dart';
import 'package:morfo/views/login/LoginScreen.dart';
import 'package:morfo/views/profile/profileScreen.dart';
import 'package:provider/provider.dart';

class TrollScreen extends StatefulWidget {
  const TrollScreen({Key? key}) : super(key: key);

  @override
  State<TrollScreen> createState() => _TrollScreenState();
}

class _TrollScreenState extends State<TrollScreen> {
  @override
  Widget build(BuildContext context) {
    final trollProv = Provider.of<TrollProvider>(context);
    final darkModeProv = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      backgroundColor: darkModeProv.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Koi Fish',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 5, // Tinggi bayangan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.logout),
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                'My Troll',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color:
                        darkModeProv.isDarkMode ? Colors.white : Colors.black),
              ),
            ),
            // Tampilkan data dari TrollProvider di sini
            // Contoh: menampilkan daftar barang
            ListView.builder(
              shrinkWrap: true,
              itemCount: trollProv.listBarang.length,
              itemBuilder: (context, index) {
                final barang = trollProv.listBarang[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(barang.gambar),
                  ),
                  title: Text(
                    barang.nama,
                    style: TextStyle(
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black),
                  ),
                  subtitle: Text(
                    '${barang.qty} x ${barang.harga}',
                    style: TextStyle(
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Hapus barang saat tombol delete ditekan
                      trollProv.removeTroll(barang);
                      // Tampilkan snackbar untuk memberi tahu pengguna bahwa barang telah dihapus
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${barang.nama} dihapus'),
                          action: SnackBarAction(
                            label: 'Batal',
                            onPressed: () {
                              // Batalkan penghapusan barang jika tombol "Batal" ditekan
                              trollProv.addTroll(barang);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total Ikan: ${trollProv.listBarang.fold(0, (total, troll) => total + troll.qty)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total Harga = ${trollProv.listBarang.fold(0, (total, troll) => total + (troll.qty * int.parse(troll.harga.replaceAll("Rp. ", ""))))}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trolley),
            label: 'Troll',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 1,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              break;
            case 1:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => TrollScreen()));
              break;
            case 2:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
              break;
          }
        },
      ),
    );
  }
}
