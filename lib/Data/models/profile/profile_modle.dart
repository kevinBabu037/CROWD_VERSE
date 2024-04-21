class ProfileModel{
   String? userName;
  final String name;
   String? eMail;
   String? joinDate;
   String? coverPic;
   String? profilepic;
   String? aboutTxt;
   String? statusTxt;
 
  ProfileModel({
    this.coverPic, 
    this.profilepic,
    this.aboutTxt,
    this.statusTxt,
     this.userName,
    required this.name,
     this.eMail,
     this.joinDate,
    });


    factory ProfileModel.fromJson( Map<String,dynamic>json){
      return ProfileModel( 
        userName: json['UserName'], 
        name: json['Name'],
        eMail:json['Email'],
        joinDate:json['UserSince'],
        coverPic: json['CoverPhoto'],
        profilepic: json['ProfilePhoto'],
        aboutTxt: json['Description'],
        statusTxt: json['Status']
        );
    }
}