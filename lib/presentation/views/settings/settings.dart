import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:crowd_verse/presentation/views/profile/profile_bloc/profile_details_bloc.dart';
import 'package:crowd_verse/presentation/views/settings/widgets/all_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key}); 

  @override 
  Widget build(BuildContext context) {
    final screenHeight=MediaQuery.of(context).size.height; 
    return Scaffold(
      backgroundColor: kClrProfileScafold, 
 
      body: Stack(
        children: [ 
          Container(
            height:screenHeight*0.3+30,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(kDefaultcoverPic),fit: BoxFit.cover)
            ),
          ),
         
           
          BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return const Center(child: CircularProgressIndicator(),);
              }
             if (state is ProfileSuccessState) { 
                 
              return Container(
                 margin:const EdgeInsets.only(top:50 ),                         
                child: Column( 
                     children: [
                      Row(
                            children: [
                             IconButton(onPressed: (){Navigator.pop(context);},
                              icon:const Icon(Icons.arrow_back)),
                             const Spacer(),
                             const Text('Settings',style: TextStyle(fontSize: 19 ),),
                             kWidth10
                            ],
                          ),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: state.profile.profilepic!=null?NetworkImage(state.profile.profilepic!):AssetImage(kDefaultProfilePic)as ImageProvider
                      ),
                      kHeight10,
                      Text(state.profile.name,style:const TextStyle(fontSize:17,fontWeight: FontWeight.bold,),),
                      Text(state.profile.eMail!,style:const TextStyle(fontSize:17,))
                     ],
                ),  
              );
             }
             return const SizedBox();
            },
          ), 
           SettingsAllItemswidget(screenHeight: screenHeight),
         
        ],
      ),
    );
  }
}



