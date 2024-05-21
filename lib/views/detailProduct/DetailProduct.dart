import 'package:flutter/material.dart';
import 'package:morfo/model/troll_model.dart';
import 'package:morfo/provider/tambahTroll_provider.dart';
import 'package:morfo/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class DetailProductScreen extends StatefulWidget {
  final data;
  const DetailProductScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    final trollProvider = Provider.of<TrollProvider>(context);
    final darkModeProv = Provider.of<DarkModeProvider>(context);

    return Scaffold(
      backgroundColor: darkModeProv.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Product Detail',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.data['gambar']),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 20),
            // Product Name
            Text(
              '${widget.data['nameProduct']}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 10),
            // Product Price
            Text(
              'Price: ${widget.data['price']}',
              style: TextStyle(
                fontSize: 18,
                color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 10),
            // Product Description
            Text(
              'detail:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${widget.data['detail']}',
              style: TextStyle(
                fontSize: 16,
                color: darkModeProv.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (qty > 1) qty -= 1;
                    });
                  },
                  child: Icon(Icons.remove, color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(qty.toString()),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      qty += 1;
                    });
                  },
                  child: Icon(Icons.add, color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                trollProvider.addTroll(
                  Troll(
                      // Ganti nilai-nilai berikut dengan nilai sesuai kebutuhan Anda
                      nama: widget.data['nameProduct'],
                      harga: 'Rp. ${widget.data['price']}',
                      gambar: '${widget.data['gambar']}',
                      qty: qty),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('${widget.data['nameProduct']} Berhasil Ditambah'),
                    action: SnackBarAction(
                      label: 'Batal',
                      onPressed: () {
                        // Batalkan penghapusan barang jika tombol "Batal" ditekan
                        trollProvider.addTroll(
                          Troll(
                            // Ganti nilai-nilai berikut dengan nilai sesuai kebutuhan Anda
                            nama: widget.data['nameProduct'],
                            harga: 'Rp. ${widget.data['price']}',
                            gambar: '${widget.data['gambar']}',
                            qty: qty,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              child: Text("Masukkan Keranjang"),
            ),
          ],
        ),
      ),
    );
  }
}
