import 'package:crowd_verse/data/models/friends/friends_model.dart';
import 'package:crowd_verse/data/models/profile/public_profile_model.dart';
import 'package:crowd_verse/data/repositories/friends/friends_serveces.dart';
import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/core/style.dart';
import 'package:crowd_verse/application/widgets/login_signup_button.dart';
import 'package:flutter/material.dart';

class PublicUserProfileDetailsWidget extends StatefulWidget {
  const PublicUserProfileDetailsWidget({
    super. key,
    required this.screenSize,
    required this.model,
  });

  final PublicProfileModel model;
  final Size screenSize;

  @override
  State<PublicUserProfileDetailsWidget> createState() => _PublicUserProfileDetailsWidgetState();
}

class _PublicUserProfileDetailsWidgetState extends State<PublicUserProfileDetailsWidget> {
  bool isFriend = false;

  @override
  void initState() {
    super.initState();
    checkIfFriend();
  }

  Future<void> checkIfFriend() async {
    List<FriendsModel>? friends = await FriendsServeses().getAllFriends();
    if (friends != null) {
      setState(() {
        isFriend = friends.any((friend) => friend.userId == widget.model.userId);
      });
    }
  }

  Future<void> handleFriendRequest() async {
    bool success = await FriendsServeses().followFriend(widget.model.userId!);
    if (success) {
      kSnakBar(context, 'Friend request sent', kClrLiteGreen);
    } else {
      kSnakBar(context, 'Already requested check in pending', kClrLiteRed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: widget.screenSize.width - 35,
      decoration: BoxDecoration(
        color: kClrWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.model.name, style: kProfileNameStyle),
              SizedBox(
                height: 25, 
                child: LoginSignUpButtonWidget(
                  fontSize: 12,
                  text: isFriend ? '  Friends  ' : '  Add Friend  ',
                  onPressed: isFriend ? null : handleFriendRequest,
                ),
              ),
            ],
          ),
          Text(widget.model.userName ?? '', style: const TextStyle(fontSize: 18)),
          if (widget.model.statusTxt != null) Text(widget.model.statusTxt!, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
