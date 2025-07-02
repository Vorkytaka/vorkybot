import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [PUsers, PChats, PUserChats])
class PDatabase extends _$PDatabase {
  PDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

 LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // For production, use a file-based database
    if (Platform.environment['APP_ENV'] == 'production') {
      final file = File('/app/data/app.db');
      await file.parent.create(recursive: true);
      return NativeDatabase(file);
    }
    // For development/testing, use an in-memory database
    return NativeDatabase.memory();
  });
}
