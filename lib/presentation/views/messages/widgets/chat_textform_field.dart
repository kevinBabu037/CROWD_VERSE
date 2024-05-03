 import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/views/messages/cubit/max_line_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTextFormField extends StatefulWidget {
  const ChatTextFormField({
    super.key,
    required this.controller,
    required this.onPressed,
    required this.scrollController
    });
 final void Function()? onPressed;
 final TextEditingController? controller;
final ScrollController scrollController;

  @override
  State<ChatTextFormField> createState() => _ChatTextFormFieldState();
}

class _ChatTextFormFieldState extends State<ChatTextFormField> {
  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaxLineCubit, int>(
      builder: (context, state) { 
        return TextFormField(
          onChanged: (value) {
        context.read<MaxLineCubit>().updateMaxLine(value.length);
          },
          maxLines: state,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed:widget.onPressed, 
            icon:const Icon(Icons.send) 
            ),
            filled: true, 
            fillColor:kClrWhite,  
             hintText: 'Message',  
             border:const OutlineInputBorder(
             borderSide: BorderSide.none,   
              borderRadius: BorderRadius.all(Radius.circular(30))
            )
          ),
        );
      },
    );
  }
}
