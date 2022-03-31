import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cube_ctrl/models/user.dart';
import 'package:cube_ctrl/models/user_settings.dart';
import 'package:cube_ctrl/models/view.dart';
import 'package:flutter/cupertino.dart';




class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //final CollectionReference cubeViewCollection= FirebaseFirestore.instance.collection('CubeViews').withConverter(fromFirestore: View, toFirestore: toFirestore);
  //final CollectionReference usersCollection= FirebaseFirestore.instance.collection('Users');


  final userSettingsCollection = FirebaseFirestore
      .instance
      .collection('Users')
      .withConverter<UserSettings>(
    fromFirestore: (snapshot, _) {print(snapshot.data());return UserSettings.fromJson(snapshot.data()!,snapshot.id); },
    toFirestore: (UserSettings, _) => UserSettings.toJson(),
  );

  final cubeViewCollection = FirebaseFirestore
      .instance
      .collection('CubeViews')
      .withConverter<View>(
    fromFirestore: (snapshot, _) => View.fromJson(snapshot.data()!,snapshot.id),
    toFirestore: (View, _) => View.toJson(),
  );


  Future<void> updateUserSettings(UserSettings userSettings) async {
    return await userSettingsCollection.doc(uid).set(userSettings);
  }


  Stream<UserSettings?> get userSettings {
    print(uid);
    final snapshot = userSettingsCollection.doc(uid).snapshots();

    return snapshot.map((event) => event.exists ? event.data()! : null);
  }




  Stream<List<View>> get views {
    return cubeViewCollection
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => doc.data())
        .toList());
  }

}