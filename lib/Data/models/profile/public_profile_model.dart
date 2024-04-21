class PublicProfileModel{
   String? userName;
  final String name;
   String? userId;
   String? joinDate;
   String? coverPic;
   String? profilepic;
   String? aboutTxt;
   String? statusTxt;
 
  PublicProfileModel({
    this.coverPic, 
    this.profilepic,
    this.aboutTxt,
    this.statusTxt,
     this.userName,
    required this.name,
     this.joinDate,
     this.userId
    });


    factory PublicProfileModel.fromJson( Map<String,dynamic>json){
      return PublicProfileModel( 
        userName: json['UserName'], 
        name: json['Name'],
        joinDate:json['UserSince'],
        coverPic: json['CoverPhoto'],
        profilepic: json['ProfilePhoto'],
        aboutTxt: json['Description'],
        statusTxt: json['Status'],
        userId: json['UserID']
        );
    }
}