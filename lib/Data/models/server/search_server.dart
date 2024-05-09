
class SearchAllServerModel{
 final String name;
 final String? serverId;
 final String? serverIcon;
 final String? discription;

  SearchAllServerModel({
    required this.serverId, 
    required this.serverIcon,
    required this.name,
     this.discription,
    });

    factory SearchAllServerModel.fromJson(Map<String,dynamic> json){
      return SearchAllServerModel(
        serverId: json['server_id'], 
        serverIcon: json["icon"], 
        name: json['name'],
        discription: json['description'],
        );
    }

}