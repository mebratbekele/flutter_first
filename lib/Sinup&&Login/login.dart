import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:security_system/Validator/validator.dart';
import 'package:security_system/services/userServices.dart';


class LOGINSPAGE extends StatefulWidget {
  const LOGINSPAGE({super.key});

  @override
  State<LOGINSPAGE> createState() => LoginPage();
}

class LoginPage extends State<LOGINSPAGE> {
  // State<PasswordVisibility> createState() => _PasswordVisibilityState();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  final _userService = UserService();
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    void signup() {
      Navigator.pushNamedAndRemoveUntil(context, '/signup', (route) => false);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 116, 86),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(Icons.lock_rounded),
            ),
            const SizedBox(height: 30),
            const Text(
              "Welcome back!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Please log in to continue.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Divider(),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _usernameController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: const Icon(Icons.email),
                  prefixIconColor: Colors.black,
                  labelStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // validator: (String? value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter your Username';
                //   }
                //   return null;
                // },
                validator: (val) {
                  if (!val!.isValidEmail) {
                    return 'Enter valid email';
                  }
                },
                maxLength: 40,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(color: Colors.black),
                obscureText: !_isVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.password),
                  prefixIconColor: Colors.black,
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: Icon(
                      _isVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter your Password';
                //   }
                //   return null;
                // },
                validator: (val) {
                  if (!val!.isValidPassword) {
                    return 'Enter valid password';
                  }
                },

                maxLength: 40,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var Accounts = await _userService.readAllAccounts();
                  Accounts.forEach((account) {
                    if (account['email'] ==
                            _usernameController.text.toLowerCase() &&
                        account['password'] == _passwordController.text &&
                        account['email'] != null) {
                      Navigator.pushNamed(context, '/home',
                          arguments: _usernameController.text);
                      return;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Invalid UserName or password. Please try again.',
                            style: TextStyle(color: Colors.red),
                          ),
                          backgroundColor: Color.fromARGB(255, 225, 238, 226),
                        ),
                      );
                    }
                  });
                }
              },
              child: Text("Login"),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/forgotPassword');
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Don't have an account?",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                signup();
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
