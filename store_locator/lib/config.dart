import 'dart:io';
import 'package:flutter/foundation.dart';

String getBaseUrl() {
  if (kIsWeb) {
    return 'http://localhost:3000/';
  }
  if (Platform.isAndroid) {
    // 10.0.2.2 is Android emulator's alias to host 127.0.0.1
    return 'http://10.0.2.2:3000/';
  }
  return 'http://localhost:3000/';
}

final url = getBaseUrl();

final registration = url + "register";
final login = url + 'login';
final addtodo = url + 'createToDo';
final getToDoList = url + 'getUserTodoList';
final deleteTodo = url + 'deleteTodo';

final addShop = url + 'createShop';
final addItem = url + 'createItem';
final getItems = url + 'getItemsInshop';
final addCustomer = url + 'createCustomer';
final getItemToCustomer = url + 'getItemsWithName';
