

class BlockListModel{

final String name;
String? profilePhoto;
String? userName;
String? friendShipId;
String? userId;


  BlockListModel({ 
    required this.name,
    this.profilePhoto,
    this.userName,
    this.friendShipId,
    this.userId

    });
 
     factory BlockListModel.fromJson( Map<String,dynamic>json){
      return BlockListModel( 
        userName: json['userName'],  
        name: json['name'],
        profilePhoto: json['profilePhoto'],
        friendShipId: json['FriendShipID'],
        userId: json['userID']
        ); 
    }

}