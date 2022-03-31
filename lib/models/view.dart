class View {
  String command;
  String name;
  Map flags;
  String id;
  View({required this.name,required this.command,required this.flags, required this.id});

  View.fromJson(Map<String, dynamic> json, String docID) :name =  json['name'], command = json['command'], flags = json['flags'], id = docID;



  Map<String, dynamic> toJson() => {
    'name': name,
    'command': command,
    'flags': flags,
  };


}