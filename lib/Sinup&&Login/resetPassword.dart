// ignore: file_names
import 'package:flutter/material.dart';
import 'package:security_system/Validator/validator.dart';

class ResetPassword extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // void signup() {
    //   Navigator.pushNamedAndRemoveUntil(context, '/signup', (route) => false);
    // }

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text(' Rset Password Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(Icons.password_rounded),
            ),
            // const SizedBox(height: 30),
            // const Text(
            //   "Welcome back!",
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Reset Your Password",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  prefixIconColor: Colors.white,
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                //  if (value == null || value.isEmpty) {
                //   return 'Please enter User Name';
                // }
                validator: (val) {
                  if (!val!.isValidEmail) return 'Enter valid email';
                },
                maxLength: 40,
              ),
            ),
            // SizedBox(height: 20),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 40),
            //   child: TextField(
            //     controller: _passwordController,
            //     style: TextStyle(color: Colors.white),
            //     obscureText: true,
            //     decoration: InputDecoration(
            //       labelText: "Password",
            //       prefixIcon: Icon(Icons.password),
            //       prefixIconColor: Colors.white,
            //       labelStyle: TextStyle(color: Colors.white),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.grey),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.blue),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Process data.
                  print('form submiitted');
                }
                // String username = _usernameController.text;
                // Navigator.pushNamed(context, '/home', arguments: username);
              },
              child: const Text("Reset"),
            ),
            // SizedBox(height: 20),
            // GestureDetector(
            //   onTap: () {},
            //   child: Text(
            //     "Forgot Password?",
            //     style: TextStyle(
            //       color: Colors.blue,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 40),
            // Text(
            //   "Don't have an account?",
            //   style: TextStyle(fontSize: 16),
            // ),
            // SizedBox(height: 10),
            // GestureDetector(
            //   onTap: () {
            //     signup();
            //   },
            //   child: Text(
            //     "Sign Up",
            //     style: TextStyle(
            //       color: Colors.blue,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 18,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
