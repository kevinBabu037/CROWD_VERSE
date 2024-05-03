class SearchAllUserModel{
String? name;
String? profilePhoto;
String? userName;
String? userId;



  SearchAllUserModel({
    this.name,
    this.profilePhoto,
    this.userName,
    this.userId,
   
    });


    

     factory SearchAllUserModel.fromJson( Map<String,dynamic>json){
      return SearchAllUserModel(  
        userName: json['UserName'],  
        name: json['Name'],
        profilePhoto: json['ProfilePhoto'], 
        userId: json['UserID'],
        
        ); 
    }
}