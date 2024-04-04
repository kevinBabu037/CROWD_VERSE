

class UserModel{
   String userName;
   String name;
   String eMail;
   String password;

   UserModel({
    required this.userName,
    required this.name,
    required this.eMail,
    required this.password
    });

   factory UserModel.fromJson( Map<String,dynamic>json){
      return UserModel(
        userName: json['UserName'],
        name: json['Name'],
        eMail:json['Email'],
        password: json['Password']
        );
    }

}