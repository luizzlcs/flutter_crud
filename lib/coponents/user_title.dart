import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/povider/users_provider.dart';
import 'package:flutter_crud/views/user_form.dart';
import 'package:provider/provider.dart';

class UserTitle extends StatelessWidget {
  final User user;

  const UserTitle({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsersProvider userProvider = Provider.of(context);
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? const CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
          );
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserForm(user: user),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.orange,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Excluir usuário'),
                    content: const Text('Tem certeza?'),
                    actions: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Não'),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Provider.of<UsersProvider>(context, listen: false)
                              .remove(user);
                          Navigator.pop(context);
                        },
                        child: Text('Sim'),
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
