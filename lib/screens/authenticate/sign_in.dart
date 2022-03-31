import 'dart:io';

import 'package:cube_ctrl/services/auth.dart';
import 'package:cube_ctrl/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:cube_ctrl/shared/validator.dart';
import 'package:cube_ctrl/shared/constants.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey =GlobalKey<FormState>();
  String email='';
  String password='';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? const Loading(): Scaffold(
      //backgroundColor:  Color(0xff525053),
        appBar: AppBar(
          backgroundColor: Colors.purple[300],
          elevation: 0.0,
          title: Text('Sign in to CubeCtrl'),
          actions: <Widget>[
        TextButton.icon(
        onPressed: () => {widget.toggleView()},
      icon: Icon(Icons.person , color: Colors.white,),
      style: TextButton.styleFrom(primary: Colors.white),
      label: Text('Register'),)
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        validator: (val) => val!.isNotEmpty && EmailValidator.isEmail(val) ? null: 'Enter an email',
                        decoration:  textInputDecoration.copyWith(hintText: "Email"),
                        onChanged: (val) {
                          setState(() {email=val;});
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        validator: (val) => val!.isEmpty | (val.length < 8)  ? 'Password needs to be at least 8 chars long' : null,
                        decoration:  textInputDecoration.copyWith(hintText: "Password"),
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {password=val;});
                        }),
                    SizedBox(height: 20.0,),
                    ElevatedButton(
                      child: Text('Sign in'),
                      style: ElevatedButton.styleFrom(primary: Colors.red[300],
                        textStyle: TextStyle(color: Colors.white),),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading=true;
                          });
                          print(email);
                          print(password);
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            print('error in signInWithEmailAndPassword ');
                            setState(() {
                              loading=false;
                            });
                          } else {
                            print('User signed in');
                            print(result);
                          }
                        } else {
                          print("No valid email or password, cant sign in");

                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}


