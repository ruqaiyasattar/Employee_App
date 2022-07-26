
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:employee/local/entity/employe_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'app_db.g.dart';

LazyDatabase _openconnection(){
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path,'employee.sqlite'));

    return NativeDatabase(file);
  } );
}

@DriftDatabase(tables: [Employee])
class AppDb extends _$AppDb{
  AppDb() : super(_openconnection());

  @override
  int get schemaVersion => 1;
  //get the list employee
  Future<List<EmployeeData>>getEmployees () async {
    return await select(employee).get();
  }

  Stream<List<EmployeeData>> getEmployeeStream () {
    return select(employee).watch();
  }
  //get particular employee
  Future<EmployeeData>getEmployee (int id) async {
    return await (select(employee)..where((tbl) => tbl.id.equals(id))).getSingle();
  }
  //update employee table value
  Future<bool> updateEmployee (EmployeeCompanion entity) async {
    return await update(employee).replace(entity);
  }
  //insert in employee table
  Future<int> insertEmployee (EmployeeCompanion entity) async {
    return await into(employee).insert(entity);
  }
  //delete in employee table
  Future<int> deletEmployee (int id) async {
    return await (delete(employee)..where((tbl) => tbl.id.equals(id))).go();
  }
}

