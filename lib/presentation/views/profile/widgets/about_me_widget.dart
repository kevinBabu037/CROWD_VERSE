
import 'package:crowd_verse/utils/core/coverpic_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../utils/core/color.dart';
import '../../../../utils/core/height_width.dart';
import '../profile_bloc/profile_details_bloc.dart';

class AboutMeWidget extends StatelessWidget {
  const AboutMeWidget({
    super.key,
    required this.screenSize, 
  });
  
  final Size screenSize;
  
 @override
Widget build(BuildContext context) {
  context.read<ProfileDetailsBloc>().add(DisplayProfileEvent()); 
  return Container(
    padding: const EdgeInsets.only(left: 10, top: 15, bottom: 20, right: 3),
    width: screenSize.width - 35,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10), 
      color: kClrWhite,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
          builder: (context, state) {
            if (state is ProfileSuccessState && state.profile.aboutTxt != null ) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Me',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.profile.aboutTxt!,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ); 
            }
            return const SizedBox(); 
          },
        ),
        SizedBox(height: kHeight10),
        const Text(
          'Croud Verse Member Since',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const ShimmerCoverPicLoading(height: 120);
            }
            if (state is ProfileSuccessState) {
              DateTime joinDate = DateTime.parse(state.profile.joinDate.split(' ')[0]);
              String formattedDate = DateFormat.yMMMMd().format(joinDate);
              return Text(
                formattedDate,
                style: const TextStyle(fontSize: 18),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    ),
  );
}
}
