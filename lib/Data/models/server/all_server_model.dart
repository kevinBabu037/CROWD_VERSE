class ServerModel{
 final String? serverId;
 final String? serverIcon;

  ServerModel({
    required this.serverId, 
    required this.serverIcon
    });

    factory ServerModel.fromJson(Map<String,dynamic> json){
      return ServerModel(
        serverId: json['server_id'], 
        serverIcon: json["Icon"], 
        );
    }

}