import 'package:flutter/material.dart';
import 'package:morfo/data/data.dart';
import 'package:morfo/model/troll_model.dart';
import 'package:morfo/provider/tambahTroll_provider.dart';
import 'package:morfo/provider/theme_provider.dart';
import 'package:morfo/views/detailProduct/DetailProduct.dart';
import 'package:morfo/views/login/loginScreen.dart';
import 'package:morfo/views/profile/profileScreen.dart';
import 'package:morfo/views/troll/trollScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final trollProvider = Provider.of<TrollProvider>(context);
    final darkModeProv = Provider.of<DarkModeProvider>(context);
    List<Map<String, dynamic>> filteredProducts = productList.where((product) {
      final productName = product['nameProduct'].toString().toLowerCase();
      final searchTerm = _searchController.text.toLowerCase();
      return productName.contains(searchTerm);
    }).toList();

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
                  Icon(Icons.logout, color: Colors.red),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Product Kami',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            TextField(
              controller: _searchController,
              style: TextStyle(
                color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: (filteredProducts.length / 2).ceil(),
                itemBuilder: (context, index) {
                  final int item1Index = index * 2;
                  final int item2Index = index * 2 + 1;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (item1Index < filteredProducts.length) ...[
                        _buildProductItem(
                          filteredProducts[item1Index],
                          darkModeProv,
                          trollProvider,
                        ),
                      ],
                      if (item2Index < filteredProducts.length) ...[
                        _buildProductItem(
                          filteredProducts[item2Index],
                          darkModeProv,
                          trollProvider,
                        ),
                      ],
                    ],
                  );
                },
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
        currentIndex: 0,
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

  Widget _buildProductItem(Map<String, dynamic> product,
      DarkModeProvider darkModeProv, TrollProvider trollProvider) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailProductScreen(data: product),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product['gambar'],
                width: 150,
                height: 140,
                fit: BoxFit.cover,
              ),
              Text(
                product['nameProduct'],
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Rp. ${product['price']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          darkModeProv.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InputChip(
                    backgroundColor: Colors.black,
                    label: Text(
                      'Tambah',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      trollProvider.addTroll(
                        Troll(
                            nama: product['nameProduct'],
                            harga: 'Rp. ${product['price']}',
                            gambar: product['gambar'],
                            qty: 1),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${product['nameProduct']} Berhasil Ditambah'),
                          action: SnackBarAction(
                            label: 'Batal',
                            onPressed: () {
                              // Batalkan penambahan barang jika tombol "Batal" ditekan
                              trollProvider.removeTroll(product['nameProduct']);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
