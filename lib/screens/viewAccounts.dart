import 'package:flutter/material.dart';
import 'package:security_system/model/account.dart';
import 'package:security_system/screens/EditAccount.dart';
import 'package:security_system/screens/viewACC.dart';
import 'package:security_system/services/userServices.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Account',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}

class ViewAccounts extends StatefulWidget {
  const ViewAccounts({Key? key}) : super(key: key);

  @override
  State<ViewAccounts> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ViewAccounts> {
  // late List<User> _userList = <User>[];
  late List<Account> _accountList = <Account>[];
  final _userService = UserService();

  getAllAccountDetails() async {
    var Accounts = await _userService.readAllAccounts();
    _accountList = <Account>[];
    Accounts.forEach((account) {
      setState(() {
        var accountModel = Account();
        accountModel.id = account['id'];
        accountModel.fname = account['fname'];
        accountModel.lname = account['lname'];
        accountModel.phone = account['phone'];
        accountModel.email = account['email'];
        accountModel.password = account['password'];
        _accountList.add(accountModel);
      });
    });
  }

  @override
  void initState() {
    getAllAccountDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result = await _userService.deleteAccounts(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllAccountDetails();
                      _showSuccessSnackBar('User Detail Deleted Success');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" view acounts"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: ListView.builder(
          itemCount: _accountList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewACC(
                                account: _accountList[index],
                              )));
                },
                leading: const Icon(Icons.person),
                title: Text(_accountList[index].fname ?? ''),
                subtitle: Text(_accountList[index].lname ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditAccount(
                                        account: _accountList[index],
                                      ))).then((data) {
                            if (data != null) {
                              getAllAccountDetails();
                              _showSuccessSnackBar(
                                  'Account Detail Updated Success');
                            }
                          });
                          ;
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(context, _accountList[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => const AddUser()))
      //         .then((data) {
      //       if (data != null) {
      //         getAllAccountDetails();
      //         _showSuccessSnackBar('User Detail Added Success');
      //       }
      //     });
      //   },
      //   // child: const Icon(Icons.add),
      // ),
    );
  }
}
