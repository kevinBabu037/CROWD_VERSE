class ProfileModel{
   final String userName;
  final String name;
  final String eMail;
  final String joinDate;
  // final String coverPic;
 
  ProfileModel( {
    // required this.coverPic, 
    required this.userName,
    required this.name,
    required this.eMail,
    required this.joinDate

    });


    factory ProfileModel.fromJson( Map<String,dynamic>json){
      return ProfileModel(
        userName: json['UserName'], 
        name: json['Name'],
        eMail:json['Email'],
        joinDate:json['UserSince'],
        // coverPic: json['CoverPhoto']
        );
    }
}