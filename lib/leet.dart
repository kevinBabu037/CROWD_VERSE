void main() {

  List<int> nums=[1,3,5,7,9,23,65,];
  int total = 12;

  for (int i = 0; i < nums.length; i++) {

     for (int j = i+1; i < nums.length-1; j++) {

       if (nums[i]+nums[j]==total) {
           print("${nums[i]}--${nums[j]}");
       }
       
     }
  }

  
}


// kevin (1,2,3)
// Akash (1,3,6)
// Deepak(12,15,20)



//  test(List<String> str){
//     List<String> res=[];
    
//     for(int i=0;i<str.length;i++){
     
//        List<String> s=str[i].split('');

//       for(int j=s.length;j>0;j--){
//         String r ='';
//         r+=s[i];
//         res.add(r);
          
//       }   

        
//     }
//     return res;
    

//  }