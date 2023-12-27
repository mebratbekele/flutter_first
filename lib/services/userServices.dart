import 'dart:async';
import 'package:security_system/db_helper/repository.dart';
import 'package:security_system/model/User.dart';
import 'package:security_system/model/account.dart';
import 'package:url_launcher/url_launcher.dart';


class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }
  // create  account
  createAccount(Account account) async {
    return await _repository.signup('account', account.userMap());
  }

//Read all accounts
  readAllAccounts() async {
    return await _repository.readaccounts('account');
  }

  //Save User
  SaveUser(UserDetail user) async {
    return await _repository.insertData('users', user.userMap());
  }

  //Read All Users
  readAllUsers() async {
    return await _repository.readData('users');
  }

  //Edit User
  UpdateUser(UserDetail user) async {
    return await _repository.updateData('users', user.userMap());
  }

// update accounts
  UpdateAccount(Account account) async {
    return await _repository.updateAccount('account', account.userMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById('users', userId);
  }

  // delete accounts
  deleteAccounts(userId) async {
    return await _repository.deleteDataByIdaccount('account', userId);
  }

  Future<void> launchCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Unable to launch call: $phoneNumber');
    }
  }
}
