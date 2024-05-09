class ServerMembersModel{
 final String name;
 final String? userName;
 final String? role;
 

  ServerMembersModel({
    required this.userName, 
    required this.role,
    required this.name,

    });

    factory ServerMembersModel.fromJson(Map<String,dynamic> json){
      return ServerMembersModel(
        userName: json['userName'],  
        role: json["role"], 
        name: json['name'],

        );
    }

}