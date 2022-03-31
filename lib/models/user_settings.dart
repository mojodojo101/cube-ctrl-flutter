class UserSettings {

  final String currentView;
  final String username;
  final List<dynamic> cubeViews;
  final String id;
  UserSettings({required this.username, required this.currentView,required this.cubeViews, required this.id});

  UserSettings.fromJson(Map<String, dynamic> json, String docID) :username =  json['username'], currentView = json['currentView'], cubeViews = json['cubeViews'], id=docID;


  Map<String, dynamic> toJson() => {
    'username': username,
    'currentView': currentView,
    'cubeViews': cubeViews,
  };

}