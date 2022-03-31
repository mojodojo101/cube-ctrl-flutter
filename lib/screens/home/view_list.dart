import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cube_ctrl/models/user.dart';
import 'package:cube_ctrl/models/user_settings.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cube_ctrl/models/view.dart';
import 'package:cube_ctrl/screens/home/view_tile.dart';
import 'package:cube_ctrl/services/database.dart';
import 'package:cube_ctrl/services/auth.dart';



class ViewList extends StatefulWidget {
  const ViewList({Key? key}) : super(key: key);

  @override
  _ViewListState createState() => _ViewListState();
}

class _ViewListState extends State<ViewList> {

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    final userSetting =Provider.of<UserSettings?>(context);
    final views = Provider.of<List<View>>(context);
    return ListView.builder(
      itemCount: views.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () async {
              print("User: ${user}");
              if ( userSetting != null) {
                UserSettings newSettings=UserSettings(username: userSetting!.username, currentView: views[index].id, cubeViews: userSetting!.cubeViews, id: userSetting!.id);
                await DatabaseService(uid: user.uid ).updateUserSettings(newSettings);
              } else {
                print("No userSetting available");
              }
        },
        child: ViewTile(view: views[index], userSetting: userSetting)
        );
      },
    );
  }
}
