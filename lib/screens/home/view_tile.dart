import 'package:cube_ctrl/models/view.dart';
import 'package:cube_ctrl/models/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ViewTile extends StatelessWidget {

  final View view;
  final UserSettings? userSetting;
  bool isCurrentView=false;
  ViewTile({ required this.view, this.userSetting });


  @override
  Widget build(BuildContext context) {
    if (userSetting != null) {
      isCurrentView = (view.id == userSetting!.currentView);
    }
    return isCurrentView? Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        color: Colors.lightBlue,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25.0,
            child: Container(
              margin: const EdgeInsets.only(top: 6.0),
              child: const RiveAnimation.asset(
            'assets/rive/cube.riv',
            fit: BoxFit.contain,),
          ),
          ),
          title: Text(view.name),
          subtitle: Text('Executes command: ${userSetting!.currentView}'),
        ),
      ),
    ) :  Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        color: Colors.lightBlue,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25.0,
            child: Container(
              margin: const EdgeInsets.only(top: 6.0),
              child: const RiveAnimation.asset(
                'assets/rive/cube.riv',
                fit: BoxFit.contain,),
            ),
          ),
          title: Text(view.name),
        ),
      ),
    );
  }
}