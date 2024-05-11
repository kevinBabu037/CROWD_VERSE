class CategoreyModel{
 final String cateGoryID;
 final String name;

  CategoreyModel({
    required this.cateGoryID,
    required this.name
    });

    factory CategoreyModel.fromJson(Map<String,dynamic> json){
      return CategoreyModel(
        cateGoryID: json['CategoryID'], 
        name: json['Name']
        );
    }

}