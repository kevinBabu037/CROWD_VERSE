class ChannelChatModel{
 final String? userName;
 final String? content;
 final String? dateTime;
 final String? userProfilePic;
 final int? userID;
 final int? serverID;
 final int? channelID;


  ChannelChatModel({ 
     this.content, 
     this.dateTime,
     this.userName,
     this.userProfilePic,
     this.userID,
     this.serverID,
     this.channelID
    });

    factory ChannelChatModel.fromJson(Map<String,dynamic> json){
      return ChannelChatModel(
        content: json['Content'],    
        dateTime: json["TimeStamp"], 
        userName: json['UserName'], 
        userProfilePic: json['UserProfilePhoto'],
        userID: json['UserID'], 
        serverID: json['ServerID'],
        channelID: json['ChannelID']
        );
    }

}