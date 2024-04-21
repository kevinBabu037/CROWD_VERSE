
import 'package:crowd_verse/presentation/views/friends/friends_and_pending.dart';
import 'package:crowd_verse/presentation/views/profile/profile_bloc/profile_details_bloc.dart';
import 'package:crowd_verse/presentation/utils/core/shimmer/coverpic_shimmer.dart';
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/views/settings/settings.dart';
import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'widgets/about_me_widget.dart';
import 'widgets/firends_widget.dart';
import 'widgets/profile_details_widget.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key}); 
  
  @override
  Widget build(BuildContext context) {
    final screenSize=MediaQuery.of(context).size; 
 
    return  Scaffold(
      backgroundColor:kClrProfileScafold, 
     body: SingleChildScrollView( 
       child: Stack( 
         children: [
           Column(
             children: [
             BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
               builder: (context, state) { 
                if (state is ProfileLoadingState) { 
                   return const ShimmerCoverPicLoading(height: 200,);  
                }
                if (state is ProfileSuccessState) { 
                  return InstaImageViewer( 
                    child: SizedBox( 
                         width: double.infinity,   
                          height:screenSize.height*0.2, 
                          child:FadeInImage( 
                           placeholder: AssetImage(kDefaultcoverPic),
                            image:state.profile.coverPic!=null?  NetworkImage(state.profile.coverPic!,): 
                             AssetImage(kDefaultcoverPic) as ImageProvider<Object>, 
                            fit: BoxFit.cover,  
                             ) 
                        ),
                  );
                }
                return const SizedBox();
                  
               }, 
             ),
       
             SizedBox(height:screenSize.height*0.1-25,),      
             ProfileDetailsWidget(screenSize: screenSize) ,
             kHeight20, 
        
             AboutMeWidget(screenSize: screenSize),
             kHeight20, 
       
             GestureDetector(
              onTap: () {
                kNavigationPush(context,const FriendsAndPending()); 
              },
              child: FriendsWidget(screenSize: screenSize)
              )
         
             ],   

           ),
            BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>( 
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  const Center(child: CircularProgressIndicator(),);
                }
               else if (state is ProfileSuccessState){ 
                  return Positioned(
                     left: 30 ,  
                       top: screenSize.height*0.1+28,  
                       child: CircleAvatar(  
                          backgroundColor:kClrWhite ,  
                         radius: 50,
                         child:InstaImageViewer( 
                           child: CircleAvatar(  
                            backgroundColor: kClrBlue,
                            radius: 45, 
                            backgroundImage: state.profile.profilepic !=null? NetworkImage(state.profile.profilepic!):
                             AssetImage(kDefaultProfilePic) as ImageProvider<Object>     
                           ),
                         ) , 
                       ),  
                     );  
                }
                return const SizedBox(height: 300,width: double.infinity,); 
              }, 
            ),   
              Positioned( 
                top: 30 , 
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    kNavigationPush(context,const ScreenSettings());
                  },
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: kClrBlack.withOpacity(0.5),
                    child:const Icon(Icons.settings,color:kClrWhite,),
                  ),
                ),
              ) 
         ],
       ),
     ),
   
    );
  }
}






