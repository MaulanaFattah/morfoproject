import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morfo/provider/theme_provider.dart';
import 'package:morfo/views/home/HomeScreen.dart';
import 'package:morfo/views/login/LoginScreen.dart';
import 'package:morfo/views/pengaturan/pengaturanScreen.dart';
import 'package:morfo/views/troll/trollScreen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
                // primary: Colors.white,
                elevation: 5,
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
                  SizedBox(width: 5),
                  Text("Logout"),
                ],
              ),
            ),
          ),
          PopupMenuButton<MenuItem>(
            onSelected: (value) {
              if (value == MenuItem.Profil) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              } else if (value == MenuItem.Pengaturan) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PengaturanScreen()));
              } else if (value == MenuItem.Logout) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: MenuItem.Profil,
                child: Text('Profil'),
              ),
              PopupMenuItem(
                value: MenuItem.Pengaturan,
                child: Text('Pengaturan'),
              ),
              PopupMenuItem(
                value: MenuItem.Logout,
                child: Text('Logout'),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 50,
                        // Add your avatar image here
                        backgroundImage: AssetImage('assets/avatar.png'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Nama: John Doe",
                        style: TextStyle(
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Email: johndoe@gmail.com",
                        style: TextStyle(
                          fontSize: 16,
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Alamat: Jakarta, Indonesia",
                        style: TextStyle(
                          fontSize: 16,
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(
              height: 20,
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
}

enum MenuItem { Profil, Pengaturan, Logout }
