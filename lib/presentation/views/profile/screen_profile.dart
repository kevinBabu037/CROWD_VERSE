
import 'package:crowd_verse/presentation/views/profile/profile_bloc/profile_details_bloc.dart';
import 'package:crowd_verse/utils/core/coverpic_shimmer.dart';
import 'package:crowd_verse/utils/core/color.dart';
import 'package:crowd_verse/utils/core/functions.dart';
import 'package:crowd_verse/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/views/profile/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/about_me_widget.dart';
import 'widgets/firends_widget.dart';
import 'widgets/profile_details_widget.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key}); 
  
  @override
  Widget build(BuildContext context) {
    final screenSize=MediaQuery.of(context).size; 

    return  Scaffold(
      backgroundColor:const Color.fromARGB(255, 248, 243, 243), 
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
                  return SizedBox(
                       width: double.infinity,   
                        height:screenSize.height*0.2,
                        child:FadeInImage(
                         placeholder:const AssetImage('assets/defalt_cover_pic1.png'),
                          image:state.profile.coverPic!=null?  NetworkImage(state.profile.profilepic!,):
                          const AssetImage('assets/defalt_cover_pic1.png') as ImageProvider<Object>,
                          fit: BoxFit.cover,  
                           ) 
                      );
                }
                return const SizedBox();
                  
               }, 
             ),
       
             SizedBox(height:screenSize.height*0.1-25,),      
             ProfileDetailsWidget(screenSize: screenSize) ,
             SizedBox(height: kHeight20,),
        
             AboutMeWidget(screenSize: screenSize),
             SizedBox(height: kHeight20,), 
       
             FriendsWidget(screenSize: screenSize)
        
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
                         child:CircleAvatar( 
                          backgroundColor: kClrBlue,
                          radius: 45, 
                          child:Container(color: Colors.black45,)

                        //    state.profile.profilepic !=null? NetworkImage(state.profile.profilepic!):
                        //  const AssetImage('assets/default_profile_pic.png') as ImageProvider<Object>     
                         ) , 
                       ),  
                     );  
                }
                return const SizedBox(); 
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






