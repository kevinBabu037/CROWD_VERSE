import 'package:flutter/material.dart';

class GoogleAuthWidget extends StatelessWidget {
  const GoogleAuthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center( 
      child: GestureDetector(
       onTap: () {
         
       },
        child: Container( 
         height: 45, 
         width: 130, 
         decoration: BoxDecoration( 
           border: Border.all(width: 0.3),  
           borderRadius: BorderRadius.circular(100),
         ),
         child: Row(children: [
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8), 
           child: Image.asset('assets/goole_logo.webp',),
         ), 
         const Text("Google")  
         ],), 
        ),
      ), 
    );
  }
}