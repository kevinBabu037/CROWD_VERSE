

class FriendsModel{

final String name;
String? profilePhoto;
String? userName;
String? friendShipId;
String? userId;
String? lastMsg;
String? lastMsgTime;


  FriendsModel({ 
    required this.name,
    this.profilePhoto,
    this.userName,
    this.friendShipId,
    this.userId,
    this.lastMsg,
    this.lastMsgTime
    });
 
     factory FriendsModel.fromJson( Map<String,dynamic>json){
      return FriendsModel( 
        userName: json['userName'],  
        name: json['name'],
        profilePhoto: json['profilePhoto'],
        friendShipId: json['FriendShipID'],
        userId: json['userID'],
        lastMsg: json['LastMessage'],
        lastMsgTime: json['UpdateAt']
        ); 
    }

}