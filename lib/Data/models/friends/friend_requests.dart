class FriendRequestsModel{
String? name;
String? profilePhoto;
String? userName;
String? friendShipId;
String? time;

  FriendRequestsModel({
     this.name,
    this.friendShipId,
    this.profilePhoto,
    this.userName,
    this.time
    });


    

     factory FriendRequestsModel.fromJson( Map<String,dynamic>json){
      return FriendRequestsModel(  
        userName: json['userName'],  
        name: json['name'],
        profilePhoto: json['profilePhoto'],
        friendShipId: json['FriendShipID'],
        time: json['UpdateAt']
        ); 
    }
}