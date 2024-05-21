import 'package:flutter/material.dart';
import 'package:morfo/provider/theme_provider.dart';
import 'package:morfo/views/Registrasi/Registrasi.dart';
import 'package:morfo/views/bottomnav/BottomNav.dart';
import 'package:morfo/views/home/HomeScreen.dart';
import 'package:morfo/views/profile/profileScreen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _inputEmailUserController =
      TextEditingController();
  final TextEditingController _InputPasswordUserController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final darkModeProv = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      backgroundColor: darkModeProv.isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Container(
              child: Column(
                children: [
                  Image.asset('assets/images/logo-apps.png', width: 150),
                  Container(
                    child: Text(
                      'Lets Sign you in',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Sign in with your data that you have \n entered during your registration',
                      style: TextStyle(
                        fontSize: 12,
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.pink,
                              ),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: darkModeProv.isDarkMode
                                    ? Colors.white
                                    : Colors.pink,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ));
                            },
                            child: Text(
                              'Registrasi',
                              style: TextStyle(
                                color: darkModeProv.isDarkMode
                                    ? Colors.white
                                    : Colors.pink,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextField(
                        controller: _inputEmailUserController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                          hintText: 'Email Adress',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          hintStyle: TextStyle(
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextField(
                        controller: _InputPasswordUserController,
                        obscureText: mounted,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                          hintText: 'Password',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          hintStyle: TextStyle(
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 5, // Tinggi bayangan
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
