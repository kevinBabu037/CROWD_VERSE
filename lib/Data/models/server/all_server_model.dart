class ServerModel{
 final String? serverId;
 final String? serverIcon;
 final String? name;

  ServerModel({
    required this.serverId, 
    required this.serverIcon,
    required this.name
    });

    factory ServerModel.fromJson(Map<String,dynamic> json){
      return ServerModel(
        serverId: json['server_id'], 
        serverIcon: json["Icon"], 
        name: json['name']
        );
    }

}