
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../utils/core/color.dart';
import '../../../../utils/core/height_width.dart';
import '../bloc/profile_details_bloc.dart';

class AboutMeWidget extends StatelessWidget {
  const AboutMeWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    context.read<ProfileDetailsBloc>().add(ProfileDetailsEvent());
    return Container(
      padding:const EdgeInsets.only(left: 10,top: 10,bottom: 10 ,right: 3), 
       height: screenSize.height*0.2,
       width: screenSize.width-35,
       decoration:  BoxDecoration(
       borderRadius: BorderRadius.circular(10),
      color:kClrWhite,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [ 
        const Text('About Me',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold ),),
        const Text('This text is about me some random text, by',style: TextStyle(fontSize:18),),
         SizedBox(height: kHeight10,),
        const Text('Croud Verse Member Since',style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold ),),
        BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
          builder: (context, state) {
            if(state is ProfileSucessesState){
               DateTime joinDate =DateTime.parse(state.profile.joinDate.split(' ')[0]);
              String formattedDate = DateFormat.yMMMMd().format(joinDate);
             return  Text(formattedDate,style:const TextStyle(fontSize:18 ),);
            }
            return const Center(child: CircularProgressIndicator(),);
          },
        ), 
       ],
      ),
    );
  }
}
