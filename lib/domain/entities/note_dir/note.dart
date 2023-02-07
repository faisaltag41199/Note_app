import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)

class Note extends Equatable{

  @HiveField(0)
  int id;

  @HiveField(1,defaultValue:'')
  String? title;

  @HiveField(2,defaultValue:'')
  String? content;

  Note({required this.id,this.title,this.content});

  @override
   List<Object?> get props => [this.id,this.title,this.content];

}