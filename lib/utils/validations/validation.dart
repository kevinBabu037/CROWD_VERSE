class Validator {

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }
    final emailRegExp = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); 
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
  //////////////
  
   static String? validateNameAndUserName(String? value){
      if (value == null || value.isEmpty) {
      return 'required';
    }
    
      if(value.trim().length<3){
        return "Not valid";
      }
      return null;

   }

   ///////////////////

    static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }

    // Check for capital letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one capital letter';
    }

    // Check for special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    // Check for number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // Check length
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }
    
  
 ///////////////////////
    
   static String? aboutTxtValidator(String? value){
      value!.trim(); 
       if ( value.length>140) {
         return " Please keep it within 140 characters"; 
       }
       return null;
    }



}