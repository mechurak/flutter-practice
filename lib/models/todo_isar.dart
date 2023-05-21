import 'package:isar/isar.dart';

part 'todo_isar.g.dart';  // build_runner 에서 자동으로 만들어 주는 코드 사용할 거임

@collection
class TodoIsar {
  Id id = Isar.autoIncrement;  // Isar가 자동으로 채워 줌
  late String title;  // late: 읽을 때 초기화 되어 있지 않으면 error
  String? description;  // 요건 null 가능

  @override
  String toString() {
    return "Todo(id: $id, title: $title, description: $description)";
  }
}