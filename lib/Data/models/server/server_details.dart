class ServerDetailsModel{
 final String name;
 final String? serverId;
 final String? serverIcon;
final String? discription;
final String? onlineUsers;

  ServerDetailsModel({
    required this.serverId, 
     this.serverIcon,
    required this.name,
     this.discription,
     this.onlineUsers
    });

    factory ServerDetailsModel.fromJson(Map<String,dynamic> json){
      return ServerDetailsModel(
        serverId: json['server_id'], 
        serverIcon: json["icon"], 
        name: json['name'],
        discription: json['description'],
        onlineUsers: json['OnlineUsers']
        );
    }

}