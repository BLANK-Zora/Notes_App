import 'package:isar/isar.dart';
// this file in needed to generate the file
// then run: dart run build_runner build
part 'note.g.dart';
@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}
