import 'package:flutter/material.dart';
import 'package:flutter_crud/coponents/user_title.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/povider/users_provider.dart';
import 'package:flutter_crud/routers/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final UsersProvider users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuários'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: users.count,
          itemBuilder: (context, i) {
            return UserTitle(
              user: users.bayIndex(i),
            );
          }),
    );
  }
}
