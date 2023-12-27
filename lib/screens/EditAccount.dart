import 'package:flutter/material.dart';
import 'package:security_system/model/account.dart';
import 'package:security_system/services/userServices.dart';

class EditAccount extends StatefulWidget {
  final Account account;
  const EditAccount({Key? key, required this.account}) : super(key: key);

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  var _fnameController = TextEditingController();
  var _lnameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _ConfirmpasswordController = TextEditingController();
  bool _validatefName = false;
  bool _validatelName = false;
  bool _validatePhone = false;
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validateConfirmPassword = false;
  String? confirmedPassword = '';
  var _userService = UserService();

  @override
  void initState() {
    setState(() {
      _fnameController.text = widget.account.fname ?? '';
      _lnameController.text = widget.account.lname ?? '';
      _phoneController.text = widget.account.phone ?? '';
      _emailController.text = widget.account.email ?? '';
      _passwordController.text = widget.account.password ?? '';
      _ConfirmpasswordController.text = widget.account.password ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite CRUD"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Account',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _fnameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter First Name',
                    labelText: 'FirstNme',
                    errorText:
                        _validatefName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _lnameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Last Name',
                    labelText: 'LasttNme',
                    errorText:
                        _validatelName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Email',
                    labelText: 'Email',
                    errorText:
                        _validateEmail ? 'Email Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter PhoneNumber',
                    labelText: 'PhoneNumber',
                    errorText: _validatePhone
                        ? 'PhoneNumber Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Password',
                    labelText: 'Password',
                    errorText: _validatePassword
                        ? 'Password Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _ConfirmpasswordController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Confirm Password',
                    labelText: 'Confirm Password',
                    errorText: _validatePassword
                        ? 'Confirm Value Can\'t Be Empty'
                        : null,
                    error: Text(
                      "$confirmedPassword",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _fnameController.text.isEmpty
                              ? _validatefName = true
                              : _validatefName = false;
                          _lnameController.text.isEmpty
                              ? _validatelName = true
                              : _validatelName = false;
                          _emailController.text.isEmpty
                              ? _validateEmail = true
                              : _validateEmail = false;
                          _phoneController.text.isEmpty
                              ? _validatePhone = true
                              : _validatePhone = false;
                          _passwordController.text.isEmpty
                              ? _validatePassword = true
                              : _validatePassword = false;
                          _ConfirmpasswordController.text.isEmpty
                              ? _validateConfirmPassword = true
                              : _validateConfirmPassword = false;
                        });
                        if (_validatefName == false &&
                            _validatelName == false &&
                            _validateEmail == false &&
                            _validatePhone == false &&
                            _validatePassword == false &&
                            _validateConfirmPassword == false) {
                          // print("Good Data Can Save");
                          var _account = Account();
                          _account.id = widget.account.id;
                          _account.fname = _fnameController.text;
                          _account.lname = _lnameController.text;
                          _account.email = _emailController.text;
                          _account.phone = _phoneController.text;
                          _account.password = _passwordController.text;
                          if (_passwordController.text ==
                              _ConfirmpasswordController.text) {
                            var result =
                                await _userService.UpdateAccount(_account);
                            Navigator.pop(context, result);
                          } else {
                            confirmedPassword = 'Password Not Confirmed';
                          }
                        }
                      },
                      child: const Text('Update Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _fnameController.text = '';
                        _lnameController.text = '';
                        _phoneController.text = '';
                        _emailController.text = '';
                        _passwordController.text = '';
                      },
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
