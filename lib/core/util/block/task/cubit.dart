import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:to_do_app/core/util/block/task/states.dart';

class TasksBloc extends Cubit<TasksStates>{
   late Database database;
   var datetimeLineSelected = DateTime.now();
  // void dt () async {
  //     var databasesPath = await getDatabasesPath();
  //   String path = p.join(databasesPath, 'tasks.db');
  //   await databaseFactory.deleteDatabase(path).catchError((error) {
  //         debugPrint('Error ${error.toString}');
  //       });
  //       emit(dtt());
  //   debugPrint('deleted');
  // }
  
  TasksBloc() : super(TasksnitialState());
  static TasksBloc get(context) => BlocProvider.of<TasksBloc>(context);

  var textEditingController = TextEditingController();
  String? reminderValue = '10m';
  String? repratedValue = 'Weekly';
  String status = 'UnCompelete';
  late String selectedPopupMenuItem;


  void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'tasks.db');

    debugPrint('AppDatabaseInitialized');

    opentasksDatabase(
      path: path,
    );

    emit(TasksDatabaseInitialized());
  }

    void opentasksDatabase({required String path}) async {
     openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT,
           reminder TEXT, repeat TEXT, status TEXT, date TEXT , startTime TEXT,
            endTime TEXT, isChecked INTEGER)''',
        ).catchError((error) {
          debugPrint('Error ${error.toString}');
        });
        debugPrint('Table Created');
      },
      onOpen: (Database db) {
        debugPrint('AppDatabaseOpened');
        database = db;

      getTasks();
      getTasksWithStatusd(database);
      },
    ).catchError((onError){
          debugPrint(onError.toString());
    });
    emit(TasksDatabaseOpened());

  }

  deleteAll() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'tasks.db');
    Database database = await openDatabase(path);
    return await database.rawDelete("Delete from tasks");
  }
  
  void insertData(
    String title,
    String date,
    String startTime,
    String endTime,
    String reminder,
    String repeat,
    int isChecked,
    String status
   ) async {

    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'tasks.db');
    Database database = await openDatabase(path);

    await database.rawInsert(
        '''INSERT INTO tasks(title, date, startTime, endTime, reminder,
         repeat, isChecked, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?)''',
        ['$title', '$date','$startTime','$endTime','$reminder',
        '$repeat','$isChecked','$status'],
        ).then((value){
          debugPrint('inserted $value');
          emit(TasksDatabaseCreated());
          getTasks();
          getTasksWithStatusd(database);
    }).catchError((onError){
          debugPrint(onError.toString());
    });
// database.close();
  }

  void uptadetask(
     int isChecked,
     int id,
     String status
  )async{ //status = ?   , '$status'
    database.rawUpdate('''UPDATE tasks SET isChecked = ?, status = ? WHERE id = ?''',
    ['$isChecked', '$status', '$id']).then((value){
      debugPrint('updated $value');
      emit(UpdatedTask());
      getTasks();
      getTasksWithStatusd(database);
    }).catchError((onError){
      debugPrint(onError.toString());
    }
    );
  }
  
  int isCompleted = 0;

  void isCheckedValue(isCompleted) {
    if (isCompleted == 0) {
      isCompleted = 1;
    } else {
      isCompleted = 0;
    } 
    emit(TasksDatabase());
  }

    List<Map> tasks = [];

  void getTasks() async {
    emit(TasksDatabaseLoading());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      debugPrint('Tasks Fetched');
      tasks = value;
      debugPrint(tasks.toString());
      emit(TasksDatabase());
    }).catchError((onError){
      debugPrint(onError>toString());
    });
  }
  
  List<Map> completedTasks = [];
  List<Map> uncompletedTasks = [];
  List<Map> favouriteTasks = [];

  void getTasksWithStatusd(database) async {
    completedTasks = [];
    uncompletedTasks = [];
    favouriteTasks = [];
    // var databasesPath = await getDatabasesPath();
    // String path = p.join(databasesPath, 'tasks.db');
    // Database database = await openDatabase(path);
    emit(TasksDatabaseLoading());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      debugPrint('Tasks statues Fetched');
      value.forEach((element) {
        if (element['status'] == 'Compelete') {
          completedTasks.add(element);
          debugPrint(completedTasks.toString());
        }
        else if (element['status'] == 'UnCompelete') {
          uncompletedTasks.add(element);
        }else{
          favouriteTasks.add(element);
        }
      });
      debugPrint(tasks.toString());
      emit(TasksDatabase());
      //getTasks();
    }).catchError((onError){
      debugPrint(onError>toString());
    });
  }

   removeTask(id) async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'tasks.db');
    Database database = await openDatabase(path);

    await database
        .rawDelete('DELETE FROM tasks WHERE id = ?',
        ['$id']).then((value) {
          emit(RemoveTaskSuccess());
           getTasks();
           getTasksWithStatusd(database);
    }).catchError((onError){
      emit(RemoveTaskError());
      debugPrint(onError.toString());

    });

  }
  
  void selectePopupMenuItem(id){

    if (selectedPopupMenuItem == 'Compelete'){
      uptadetask(1, id, 'Compelete');
    debugPrint('Compelete');
    
    }
    if (selectedPopupMenuItem == 'UnCompelete'){
      uptadetask(0, id, 'UnCompelete');
    debugPrint('UnCompelete');
    
    }
    if (selectedPopupMenuItem == 'Favorite'){
      uptadetask(0, id, 'Favorite');
    debugPrint('Favorite');
    
    }
    if (selectedPopupMenuItem == 'delete'){
      removeTask(id);
    debugPrint('delete');
    
    }
  }

DateTime currentDate = DateTime.now();
  DateTime? currentSelectedDate;
   String? selectedDate;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050)).then((value) {
          currentDate = value!;
          currentSelectedDate = currentDate;
        selectedDate = DateFormat('dd-MM-yyyy').format(currentDate).toString();
        emit(TasksDatabase());
        });
  }

    TimeOfDay currentTime = TimeOfDay.now();
    TimeOfDay? currentSelectedTime;
     String? selectedStartTime;
  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()).then((value) {
          currentTime = value!;
          currentSelectedTime = currentTime;
        selectedStartTime = currentTime.format(context).toString();
        emit(TasksDatabase());
        });
  }

       String? selectedEndTime;
  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()).then((value) {
          currentTime = value!;
        selectedEndTime = currentTime.format(context).toString();
        emit(TasksDatabase());
        });
  }

  void onSelectedReminderValue(String value) {
     reminderValue = value;
      emit(TasksDatabase());
  }

  void onSelectedrepratedValue(String value) {
     repratedValue = value;
      emit(TasksDatabase());
  }

  void onSelectedDateTimeline(date) {
     datetimeLineSelected = date;
      emit(TasksDatabase());
  }
  late double duration = 60;
  void xy(BuildContext context) {
      print(TimeOfDay.now().format(context));
                             TimeOfDay t = currentSelectedTime??TimeOfDay.now();
                            final now =  (currentSelectedDate)??DateTime.now();
                            var xx = new DateTime(now.year, now.month, now.day, t.hour, t.minute);
                             print(xx);
                             final timestamp1 = xx.millisecondsSinceEpoch/1000.round();
                             print('${(timestamp1)} (milliseconds/1000)');
                            
                             TimeOfDay tnow = TimeOfDay.now();
                            final nownow = new DateTime.now();
                              var xxnow = new DateTime(now.year, now.month, now.day, t.hour, t.minute);
                              print(xxnow);
                              final timestamp2 = xx.millisecondsSinceEpoch/1000.round();
                            print('${(timestamp2)} (milliseconds/1000)');
                             duration = timestamp1 - timestamp2;
                            print(duration);;
      emit(TasksDatabase());
  }

}

