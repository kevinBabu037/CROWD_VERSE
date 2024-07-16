import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:crowd_verse/application/utils/core/height_width.dart';
import 'package:crowd_verse/application/utils/core/images.dart';
import 'package:crowd_verse/application/utils/core/shimmer/public_profile_shimmer.dart';
import 'package:crowd_verse/application/presentation/friends/friends_bloc/friends_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import 'public_user_about_details.dart';
import 'public_user_profile_details_widget.dart';

class PublicUserProfileDisplay extends StatefulWidget {
  const PublicUserProfileDisplay({
    super.key, required this.id,  
    required this.name
    });
  final String id;
  final String name;

  @override
  State<PublicUserProfileDisplay> createState() => _PublicUserProfileDisplayState();
}
 
class _PublicUserProfileDisplayState extends State<PublicUserProfileDisplay> {
  @override
  void initState() {
   context.read<FriendsBloc>().add(PublicUserProfileDisplayEvent(id:widget.id));
    super.initState();
  }
  @override  
  Widget build(BuildContext context) {
    final screenSize=MediaQuery.of(context).size; 

    return Scaffold(
       appBar: AppBar(
        leading: IconButton(onPressed: (){
         context.read<FriendsBloc>().add(SearchAllUsersEvent(searchTxt:'')); 
         Navigator.pop(context);
        }, 
        icon:const Icon(Icons.arrow_back)),
        title: Text(widget.name),
       
       ),
      backgroundColor: kClrProfileScafold, 
      body: BlocBuilder<FriendsBloc, FriendsState>(  
        builder: (context, state) {
          if (state is PublicProfileLoadingState){
           return const Center(child:PublicProfileShimmer(),); 
          }
          if (state is PublicProfileSuccessState){   
            return Stack(
              children: [
                Column(
                 children: [
                  InstaImageViewer( 
                          child: SizedBox( 
                               width: double.infinity,   
                                height:screenSize.height*0.2, 
                                child:FadeInImage( 
                                 placeholder: AssetImage(kDefaultcoverPic),
                                  image:
                                   state.users.coverPic!=null?  NetworkImage(state.users.coverPic!,): 
                                   AssetImage(kDefaultcoverPic) as ImageProvider<Object>, 
                                  fit: BoxFit.cover,  
                                   ) 
                              ),
                        ),
                        kHeight60,  
                   

                        PublicUserProfileDetailsWidget(screenSize: screenSize,model:state.users,),
                        kHeight30,
                        PublicUserAboutDetailsWidget(screenSize: screenSize,model:state.users,),
                      
                 ], 
                ),
                Positioned(
                           left: 30 ,  
                             top: screenSize.height*0.1+28,   
                             child: CircleAvatar(  
                                backgroundColor:kClrWhite ,  
                               radius: 50,
                               child:InstaImageViewer(  
                                  child: CircleAvatar(  
                                  backgroundColor: kClrBlue, 
                                  radius: 45,  
                                  backgroundImage: 
                                   state.users.profilepic !=null? NetworkImage(state.users.profilepic!):
                                   AssetImage(kDefaultProfilePic) as ImageProvider<Object>     
                                 ),
                               ) , 
                             ),   
                           )
              ],
            );
          }
          return const PublicProfileShimmer();
        },
      )
    );
  }
}


