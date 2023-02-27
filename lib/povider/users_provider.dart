import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/user.dart';

class UsersProvider with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USERS};

  //Retorna todos os itens da lista
  List<User> get all {
    return [..._items.values];
  }

  // conta todos os elementos da lista
  int get count {
    return _items.length;
  }

  // Retorna todos os elementos da lista pelo index
  User bayIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user == null) {
      return;
    }

    // Alteração

    if (user.id != null &&
        user.id!.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      _items.update(user.id!, (_) => user);
    } else {
      //Adicionar
      final id = Random().nextDouble().toString();

      _items.putIfAbsent(
          id,
          () => User(
                id: id,
                name: user.name,
                email: user.email,
                avatarUrl: user.avatarUrl,
              ));
    }
    notifyListeners();
  }

  void remove(User user) {
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
