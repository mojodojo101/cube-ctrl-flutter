import 'package:cube_ctrl/screens/authenticate/authenticate.dart';
import 'package:cube_ctrl/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:cube_ctrl/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final user = Provider.of<User?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}