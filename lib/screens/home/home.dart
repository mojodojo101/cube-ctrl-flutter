import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cube_ctrl/models/user_settings.dart';
import 'package:cube_ctrl/models/user.dart';
import 'package:cube_ctrl/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:cube_ctrl/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cube_ctrl/screens/home/view_list.dart';
import 'package:cube_ctrl/models/view.dart';


class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return MultiProvider(
      providers: [StreamProvider<List<View>>.value(
        value:  DatabaseService().views,
        initialData: [],),
        StreamProvider<UserSettings?>.value(
          value:  DatabaseService(uid: user!.uid ).userSettings,
          initialData: null ,)
      ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Homescreen'),
            actions: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                style: TextButton.styleFrom(primary: Colors.white),
                label: const Text('Logout'),
              ),
            ],
          ),
          body: ViewList(),
        ),
    );
  }
}
