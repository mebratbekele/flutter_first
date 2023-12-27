import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:security_system/Validator/validator.dart';
import 'package:security_system/model/account.dart';
import 'package:security_system/services/userServices.dart';

/// Flutter code sample for [Form].
class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => signupForm();
}

class signupForm extends State<signup> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Account Creation Page'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ),
        body: const FormExample(),
      ),
    );
  }
}

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isVisible = false;
  String? _emailerrorText = "",
      _passworderrorText = "",
      _confirmpassworderrorText = "";
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ConfirmPasswordController =
      TextEditingController();

  var _userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
            // width: 100%,
            child: TextFormField(
              controller: _fnameController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[a-zA-Z]+"),
                )
              ],
              decoration: const InputDecoration(
                hintText: 'Enter your Firstname',
                labelText: 'First Name',
                prefixIcon: Icon(Icons.person),
                prefixIconColor: Colors.black,
                // suffixIcon: Icon(Icons.person_2)
              ),
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter Your firstName';
              //   }
              //   return null;
              // },
              validator: (val) {
                if (!val!.isValidName) return 'Enter valid name';
              },
              maxLength: 16,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
            // width: 250.0,
            child: TextFormField(
              controller: _lnameController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-Z]+'),
                )
              ],
              decoration: const InputDecoration(
                hintText: 'Enter your Father Name',
                labelText: 'Last Name',
                prefixIcon: Icon(Icons.person),
                prefixIconColor: Colors.black,
              ),
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter Your Father Name.';
              //   }
              //   return null;
              // },
              validator: (val) {
                if (!val!.isValidName) return 'Enter valid name';
              },
              maxLength: 16,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
            // width: 250.0,
            child: TextFormField(
              controller: _emailController,
              onChanged: (value) {
                setState(() {
                  // Check if the input is a valid name
                  if (!value!.isValidEmail) {
                    _emailerrorText = 'Invalid ';
                  } else {
                    // Set the error message if the input is invalid
                    _emailerrorText = 'Looks good!';
                  }
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email Address',
                prefixIcon: const Icon(Icons.email),
                error: _emailerrorText == 'Looks good!'
                    ? Text(
                        "$_emailerrorText",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      )
                    : Text(
                        "$_emailerrorText",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                prefixIconColor: Colors.black,
              ),
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter email';
              //   }
              //   // if (!EmailValidator.validate(value)) {
              //   //   return 'Invalid email address';
              //   // }
              //   return null;
              // },
              validator: (val) {
                if (!val!.isValidEmail) {
                  return 'Enter valid email';
                }
              },
              maxLength: 40,
            ),
            // child: Text(_errorText),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
            // width: 250.0,
            child: TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                hintText: 'Enter your Phone',
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
                prefixIconColor: Colors.black,
              ),
              //
              validator: (val) {
                if (!val!.isValidPhone) return 'Enter valid phone';
              },
              maxLength: 13,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
            child: TextFormField(
              controller: _passwordController,
              onChanged: (value) {
                setState(() {
                  // Check if the input is a valid name
                  if (!value!.isValidPassword) {
                    _passworderrorText = 'Invalid ';
                  } else {
                    // Set the error message if the input is invalid
                    _passworderrorText = 'Looks good!';
                  }
                });
              },
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_isVisible,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                labelText: 'Password',
                isDense: true,
                prefixIcon: Icon(Icons.password),
                error: _passworderrorText == 'Looks good!'
                    ? Text(
                        "$_passworderrorText",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      )
                    : Text(
                        "$_passworderrorText",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
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
              validator: (val) {
                if (!val!.isValidPassword) return 'Enter valid password';
              },
              maxLength: 40,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
            // width: 250.0,
            child: TextFormField(
              controller: _ConfirmPasswordController,
              onChanged: (value) {
                setState(() {
                  // Check if the input is a valid name
                  if (!value!.isValidPassword &&
                      _passwordController.text !=
                          _ConfirmPasswordController.text) {
                    _confirmpassworderrorText = ' Not Confirmed!';
                  } else {
                    // Set the error message if the input is invalid
                    _confirmpassworderrorText = 'Confiremed!';
                  }
                });
              },
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_isVisible,
              decoration: InputDecoration(
                hintText: 'Enter confirm password',
                labelText: 'Confirm password',
                isDense: true,
                prefixIcon: Icon(Icons.password),
                error: _confirmpassworderrorText == 'Confiremed!'
                    ? Text(
                        "$_confirmpassworderrorText",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      )
                    : Text(
                        "$_confirmpassworderrorText",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
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
              validator: (val) {
                if (!val!.isValidPassword) return 'Enter valid password';
              },
              maxLength: 40,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 80.0,
            ),
            // width: 100.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Validate will return true if the form is valid, or false if

// the form is invalid.

                    if (_formKey.currentState!.validate()) {
                      // Process data.
                      var _account = Account();
                      _account.fname = _fnameController.text;
                      _account.lname = _lnameController.text;
                      _account.phone = _phoneController.text;
                      _account.email = _emailController.text;
                      _account.password = _passwordController.text;
                      print(_account.password);
                      // ignore: avoid_init_to_null
                      var result = null;
                      result = await _userService.createAccount(_account);
                      if (result != null) {
                        _fnameController.text = '';
                        _lnameController.text = '';
                        _phoneController.text = '';
                        _emailController.text = '';
                        _passwordController.text = '';
                        _ConfirmPasswordController.text = '';
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Create Your Account successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        // Navigator.pushReplacementNamed(context, '/login');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('UserName  or Password Incorrect!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    }
                  },
                  child: const Center(child: Text("Signup")),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
