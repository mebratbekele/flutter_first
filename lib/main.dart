import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:security_system/HomePage.dart';
import 'package:security_system/Sinup&&Login/login.dart';
import 'package:security_system/Sinup&&Login/resetPassword.dart';
import 'package:security_system/Sinup&&Login/signup.dart';
import 'package:security_system/auth_page.dart';
import 'package:security_system/model/User.dart';
import 'package:security_system/model/account.dart';
import 'package:security_system/screens/EditUser.dart';
import 'package:security_system/screens/addUser.dart';
import 'package:security_system/screens/viewAccounts.dart';
import 'package:security_system/screens/viewUser.dart';
import 'package:security_system/services/userServices.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//         fontFamily: 'CustomFont',
//       ),
//       home: const AuthPage(),
//       routes: {
//         "/home": (context) => FirebaseAuth.instance.currentUser != null
//             ? const NavBar()
//             : const AuthPage(),
//         "/addUsers": (context) => FirebaseAuth.instance.currentUser != null
//             ? const MyHomePage()
//             : const AuthPage(),
//         "/viewAccounts": (context) => FirebaseAuth.instance.currentUser != null
//             ? const ViewAccounts()
//             : const AuthPage(),
//         '/login': (context) => const LOGINSPAGE(),
//         '/signup': (context) => const signup(),
//         '/forgotPassword': (context) => ResetPassword(),
//         //'/camera': (context) => TakePictureScreen(camera: camera())
//       },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'CustomFont',
      ),
      home: const AuthWrapper(), // Use AuthWrapper as the home widget
      routes: {
        "/home": (context) => const AuthWrapper(
            child: NavBar()), // Use AuthWrapper for navigation
        "/addUsers": (context) => const AuthWrapper(child: MyHomePage()),
        "/viewAccounts": (context) => const AuthWrapper(child: ViewAccounts()),
        '/login': (context) => const LOGINSPAGE(),
        '/signup': (context) => const signup(),
        '/forgotPassword': (context) => ResetPassword(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final Widget? child;

  const AuthWrapper({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the user is authenticated
    if (FirebaseAuth.instance.currentUser != null) {
      // If authenticated, show the provided child widget
      return child ?? Container();
    } else {
      // If not authenticated, show the AuthPage
      return const AuthPage();
    }
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<UserDetail> _userList = <UserDetail>[];
  late List<Account> _accountList = <Account>[];
  final _userService = UserService();

  getAllUserDetails() async {
    var users = await _userService.readAllUsers();
    _userList = <UserDetail>[];
    users.forEach((user) {
      setState(() {
        var userModel = UserDetail();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        userModel.description = user['description'];
        _userList.add(userModel);
      });
    });
  }

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
        _accountList.add(accountModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
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
                    var result = await _userService.deleteUser(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllUserDetails();
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
        title: const Text("SQLite CRUD Operation in Flutter"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewUser(
                                user: _userList[index],
                              )));
                },
                leading: const Icon(Icons.person),
                title: Text(_userList[index].name ?? ''),
                subtitle: Text(_userList[index].contact ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditUser(
                                        user: _userList[index],
                                      ))).then((data) {
                            if (data != null) {
                              getAllUserDetails();
                              _showSuccessSnackBar(
                                  'User Detail Updated Success');
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
                          _deleteFormDialog(context, _userList[index].id);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddUser()))
              .then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSuccessSnackBar('User Detail Added Success');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
