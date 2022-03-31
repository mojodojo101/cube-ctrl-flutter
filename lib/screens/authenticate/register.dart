import 'package:cube_ctrl/services/auth.dart';
import 'package:cube_ctrl/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:cube_ctrl/shared/validator.dart';
import 'package:cube_ctrl/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email='';
  String password='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //backgroundColor:  Color(0xff525053),
        appBar: AppBar(
          backgroundColor: Colors.purple[300],
          elevation: 0.0,
          title: const Text('Sign in to CubeCtrl'),
          actions: <Widget>[
            TextButton.icon(
              onPressed: () => {
                widget.toggleView()
              },
              icon: const Icon(Icons.person , color: Colors.white,),
              style: TextButton.styleFrom(primary: Colors.white),
              label: const Text('SignIn'),)
          ],
        ),
        body: Stack(
          children: <Widget>[
            Loading(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    TextFormField(
                        validator: (val) => val!.isNotEmpty && EmailValidator.isEmail(val) ? null: 'Enter an email',
                        decoration:  textInputDecoration.copyWith(hintText: "Email"),
                        onChanged: (val) {
                          setState(() {email=val;});
                        }),
                    const SizedBox(height: 20.0),
                    TextFormField(
                        validator: (val) => val!.isEmpty | (val.length < 8)  ? 'Password needs to be at least 8 chars long' : null,
                        decoration: textInputDecoration.copyWith(hintText: "Password"),
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {password=val;});
                        }),
                    const SizedBox(height: 20.0,),
                    ElevatedButton(
                      child: const Text('Register'),
                      style: ElevatedButton.styleFrom(primary: Colors.red[300],
                        textStyle: const TextStyle(color: Colors.white),),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print(email);
                          print(password);
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            print('error in RegisterWithEmailAndPassword');
                          } else {
                            print('User signed in');
                            print(result);
                          }
                        } else {
                          print("No valid email or password, cant register");

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


