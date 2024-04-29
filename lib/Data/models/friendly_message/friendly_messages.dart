class FriendlyChatModel{
 final String time;
 final String message ;
 final String senterId ;
 final String resrverId ;

   FriendlyChatModel({ 
    required this.time, 
    required this.message, 
    required this.senterId, 
    required this.resrverId
    });

 
     factory FriendlyChatModel.fromJson( Map<String,dynamic>json){
      return FriendlyChatModel(
        time: json['timestamp'],  
        message:json['content'] , 
        senterId:json['sender_id'] , 
        resrverId:json['recipient_id'] 
        );
    }


    Map<String, dynamic> toJson() {
    return {
      "Type": "text",
      "Tag":"nil",
      "content": message,
      "sender_id": senterId,
      "recipient_id": resrverId,
    };
  }
   

} 