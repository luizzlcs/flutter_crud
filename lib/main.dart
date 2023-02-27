import 'package:flutter/material.dart';
import 'package:flutter_crud/povider/users_provider.dart';
import 'package:flutter_crud/routers/app_routes.dart';
import 'package:flutter_crud/views/user_form_register.dart';
import 'package:flutter_crud/views/user_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UsersProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.HOME: (_) => const UserList(),
          AppRoutes.USER_FORM: (_) => UserFormRegister(),
        },
      ),
    );
  }
}
