import 'package:hive/hive.dart';
import 'package:air_fryer_calculator/model/enums/category_enums.dart';

part 'notesmodel.g.dart';

@HiveType(typeId: 0)
class Notes extends HiveObject{

  @HiveField(0)
  late String title;

  @HiveField(1)
  late String category;

  @HiveField(2)
  late double temperature;

  @HiveField(3)
  late double time;

  @HiveField(4)
  late String? notes;

  @HiveField(5)
  late bool isCelcius;





}