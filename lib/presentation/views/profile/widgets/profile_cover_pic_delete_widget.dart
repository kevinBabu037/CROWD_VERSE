import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/views/profile/profile_bloc/profile_details_bloc.dart';
import 'package:crowd_verse/presentation/views/profile/widgets/status_and_edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProFileCoverDeletButtonWidget extends StatelessWidget {
  const ProFileCoverDeletButtonWidget({
    super.key,
    required this.screenSize
  });
  final Size screenSize;
  @override
  Widget build(BuildContext context) { 
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
     children: [ 
        GestureDetector(
          onTap: () {
            kShowDialog(
            context: context, 
             title: 'Delete', 
              contentTxt: "Are you sure want to delete Profile picture?",
               actionBtn1Txt: "cancel", 
                actionBtn2Txt: "Delete", 
                 onPressed: () {
                   context.read<ProfileDetailsBloc>().add(DeleteProfilePicAndCoverPicEvent(type:"profile photo"));
                  Navigator.pop(context);
                 },
                 );
          },
          child: StatusAndEditWidget(screenSize: screenSize, 
          icon: Icons.delete, text: 'Profile piture')
          ),
        GestureDetector(
          onTap: () {
                kShowDialog(
            context: context,
             title: 'Delete',
              contentTxt: "Are you sure want to delete Cover Photo?",
               actionBtn1Txt: "cancel",
                actionBtn2Txt: "Delete",
                 onPressed: () { 
                  context.read<ProfileDetailsBloc>().add(DeleteProfilePicAndCoverPicEvent(type:"cover photo"));
                  Navigator.pop(context);
                 },
                 );
          },
          child: StatusAndEditWidget(screenSize: screenSize, 
          icon: Icons.delete, text: 'Cover photo ')
          ),
     
    
     
     ],
    );
  }
}
