import 'package:flutter/material.dart';
import 'package:morfo/provider/theme_provider.dart';
import 'package:morfo/views/bottomnav/BottomNav.dart';
import 'package:morfo/views/home/HomeScreen.dart';
import 'package:morfo/views/login/LoginScreen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;
  bool _passwordsMatch = true;

  @override
  Widget build(BuildContext context) {
    final darkModeProv = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      backgroundColor: darkModeProv.isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
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
                    SizedBox(height: 20),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
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
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.pink)),
                            ),
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
                    SizedBox(height: 20),
                    Text(
                      'Create your account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person,
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black),
                        labelStyle: TextStyle(
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black),
                      ),
                      style: TextStyle(
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email,
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black),
                        labelStyle: TextStyle(
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black),
                      ),
                      style: TextStyle(
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock,
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordObscure = !_isPasswordObscure;
                            });
                          },
                        ),
                        labelStyle: TextStyle(
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black),
                      ),
                      obscureText: _isPasswordObscure,
                      style: TextStyle(
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock,
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordObscure =
                                  !_isConfirmPasswordObscure;
                            });
                          },
                        ),
                        errorText:
                            _passwordsMatch ? null : 'Passwords do not match',
                        labelStyle: TextStyle(
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.black),
                      ),
                      obscureText: _isConfirmPasswordObscure,
                      onChanged: (_) {
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          setState(() {
                            _passwordsMatch = false;
                          });
                        } else {
                          setState(() {
                            _passwordsMatch = true;
                          });
                        }
                      },
                      style: TextStyle(
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black),
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        String name = _nameController.text;
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        String confirmPassword =
                            _confirmPasswordController.text;

                        if (password != confirmPassword ||
                            password.length < 2) {
                          setState(() {
                            _passwordsMatch = false;
                          });
                          return; // Stop further execution
                        }

                        print('Name: $name');
                        print('Email: $email');
                        print('Password: $password');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Registration successful'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        elevation: 5,
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
                            'Registrasi',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Login with',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // Handle Facebook login
                          },
                          icon: Icon(Icons.facebook, color: Colors.blue),
                          label: Text('Facebook'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(width: 16.0), // Spacer
                        ElevatedButton.icon(
                          onPressed: () {
                            // Handle Google login
                          },
                          icon: Icon(Icons.g_mobiledata_outlined,
                              color: Colors.red),
                          label: Text('Google'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
