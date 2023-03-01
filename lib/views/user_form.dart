import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/povider/users_provider.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  User user;
  UserForm({Key? key, required this.user}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final Map<String, String> _formDate = {};

  final formKey = GlobalKey<FormState>();

  void _loadFormDate(User user) {
    _formDate['id'] = user.id ?? '';
    _formDate['name'] = user.name ?? '';
    _formDate['email'] = user.email ?? '';
    _formDate['avatarUrl'] = user.avatarUrl ?? '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFormDate(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Usuário'),
        actions: [
          IconButton(
            onPressed: () {
              final isValido = formKey.currentState!.validate();

              if (isValido) {
                formKey.currentState!.save();
                Provider.of<UsersProvider>(context, listen: false).put(
                  User(
                    id: _formDate['id'],
                    name: _formDate['name'] ?? '',
                    email: _formDate['email'] ?? '',
                    avatarUrl: _formDate['avatarUrl'] ?? '',
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formDate['name'] ?? '',
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O campo está vazio!';
                  }
                  if (value.trim().length < 3) {
                    return 'O valor digitado é curto de mais';
                  }
                  return null;
                },
                onSaved: (value) => _formDate['name'] = value!,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: _formDate['email'] ?? '',
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "O campo E-mail precisa ser preenchido";
                  }
                  if (!value.contains('@') && !value.contains('.com')) {
                    return 'O E-mail digitado é inválido';
                  }
                  return null;
                },
                onSaved: (value) => _formDate['email'] = value!,
              ),
              TextFormField(
                initialValue: _formDate['avatarUrl'] ?? '',
                decoration: const InputDecoration(
                  labelText: 'URL Avatar',
                ),
                onSaved: (value) => _formDate['avatarUrl'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
