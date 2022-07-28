import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_phase1/presentation/completed_tasks/completed_tasks.dart';
import 'package:my_todo_phase1/presentation/cubit/todo_states.dart';
import 'package:sqflite/sqflite.dart';

import '../favorite_tasks/favorite_tasks.dart';
import '../new_tasks/new_tasks.dart';

class ToDoCubit extends Cubit<ToDoStates> {
  ToDoCubit() : super(ToDoInitialState());

  static ToDoCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> taskStatusScreens = [
    const CompletedTasks(),
    const NewTasks(),
    const FavouriteTasks(),
  ];


  int selectedReminder = 5;
  List<int> reminderList = [
    5,
    10,
    15,
    20,
  ];

  String selectedRepeat = "None";
  List<String> repeatList = [
    "Daily",
    "Weekly",
    "Monthly",
    "None",
  ];





// Create DataBase
  Database? database;

  List<Map> newTasks = [];
  List<Map> completedTasks = [];
  List<Map> favouriteTasks = [];
  List<Map> allTasks=[];

  void createDatabase() {
    openDatabase(
      'testTodo.db',
      version: 1,
      onCreate: (database, version) {
        debugPrint('The Database has been created !');
        database
            .execute('CREATE TABLE tasks '
                '(id INTEGER PRIMARY KEY, title TEXT, date TEXT, start_time TEXT,end_time TEXT, description TEXT,reminder TEXT ,status TEXT)')
            .then((value) {
          debugPrint('Table has been created !');
        }).catchError((error) {
          debugPrint(error.toString());
        });
      },
      onOpen: (database) {},
    ).then((value) {
      database = value;
      getDataFromDataBase(database);
      emit(ToDoCreateDatabaseState());
      debugPrint('The Database has been opened !');
    }).catchError((error) {
      debugPrint('Error When Creating Table ${error.toString()}');
    });
  }

  // Insert To DataBase

  void insertToDatabase({
    required title,
    required date,
    required startTime,
    required endTime,
    required description,
    String status = 'New',
  }) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert('INSERT INTO tasks '
              '(title, date, start_time,end_time ,description,status)VALUES '
              '("$title", "$date", "$startTime", "$endTime","$description", "$status")')
          .then((value) {
        debugPrint('$value inserted successfully');
        emit(ToDoInsertToDatabaseState());
        getDataFromDataBase(database);
      }).catchError((error) {
        debugPrint('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  // Get Data From DataBase

  void getDataFromDataBase(database) {
    emit(ToDoLoadingGetDataFromDatabaseState());

    newTasks = [];
    completedTasks = [];
    favouriteTasks = [];
    emit(ToDoLoadingGetDataFromDatabaseState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element["status"] == 'New') {
          newTasks.add(element);
        } else if (element['status'] == 'Done') {
          completedTasks.add(element);
        } else {
          favouriteTasks.add(element);
        }
      });

      emit(ToDoSuccessGetDataFromDatabaseState());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void updateDataInDatabase({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    required String description,
    required int id,
    required String status,
  }) {
    database!
        .update(
            'tasks',
            {
              "title": title,
              "date": date,
              "start_time": startTime,
              "end_time": endTime,
              "description": description,
              "status": status
            },
            where: 'id=?',
            whereArgs: [id])
        .then((value) {
      debugPrint('$value Updated Successfully !');

      getDataFromDataBase(database);
      emit(ToDoSuccessUpdateDatabaseState());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void updateStatusInDatabase({
    required int id,
    required String status,
  }) async {
    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(ToDoSuccessUpdateDatabaseState());
    });
  }

  void deleteDataFromDatabase({required int id}) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      debugPrint('$value Deleted Successfully');
      getDataFromDataBase(database);
      emit(ToDoSuccessDeleteDataFromDatabaseState());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }



  void getAllDataFromDataBase(database) {
    emit(ToDoLoadingGetDataFromDatabaseState());

    allTasks = [];

    emit(ToDoLoadingGetDataFromDatabaseState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element["status"] == 'New'){
        allTasks.add(element);}
        }
      );

      emit(ToDoSuccessGetAllDataFromDatabaseState());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }


}
