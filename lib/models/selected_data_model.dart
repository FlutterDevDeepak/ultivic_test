import 'package:hive/hive.dart';

 part 'selected_data_model.g.dart';

@HiveType(typeId: 0)
class DataModel{
  @HiveField(0)
  final bool isSelected;
 

  DataModel({required this.isSelected});

}