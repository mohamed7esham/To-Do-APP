import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../../../../core/util/block/task/cubit.dart';
import '../../../../core/util/block/task/states.dart';
import '../../../../services/notification_service/local_notification_service.dart';
//import 'package:intl/intl.dart';

class TaskListPerDay extends StatefulWidget {
  const TaskListPerDay({super.key});

  @override
  State<TaskListPerDay> createState() => _TaskListPerDayState();
}

class _TaskListPerDayState extends State<TaskListPerDay> {
   late final LocalNotificationService service;
  List<Color> colors = [Colors.red,const Color(0xFFff9d42),const Color(0xFFf9c50b),Colors.blue,];
   @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    //listenToNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<TasksBloc, TasksStates>(
      listener: (context, state) {},
      builder: (context, state){
        var tasks = TasksBloc.get(context).tasks;
        return RefreshIndicator(
          onRefresh: () async {
                    TasksBloc.get(context).getTasks();
                  },
          child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (tasks[index]['repeat'] == 'Dayly'){
                      DateTime date = DateFormat.jm().parse(
                        tasks[index]['startTime'].toString());
                        var myTime =DateFormat('HH:mm').format(date);
                        debugPrint(myTime);
                        service.showScheduledNewNotification(
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]),
                        TasksBloc.get(context).tasks,
                        );
                    return ClipRect(clipBehavior: Clip.hardEdge,
                      child: Container(margin: const EdgeInsets.only(bottom: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: colors[index % colors.length],
                        ),
                        child: Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.white),
                          child: CheckboxListTile(
                            title:Text(TasksBloc.get(context).tasks[index]['startTime'],
                            style: const TextStyle(color: Colors.white,fontSize: 14),),
                            subtitle: Text(TasksBloc.get(context).tasks[index]['title'],
                            style: const TextStyle(color: Colors.white),),
                            activeColor: Colors.transparent,
                            //selectedTileColor: Colors.green,
                            value: TasksBloc.get(context).tasks[index]['isChecked'] == 0 ?false:true,
                            onChanged: ( bool? value) { 
                              if(TasksBloc.get(context).tasks[index]['isChecked'] == 0){
                                 TasksBloc.get(context).uptadetask(1,
                                  TasksBloc.get(context).tasks[index]['id'],
                                  'Compelete'
                                  );
                                 }else{
                                 TasksBloc.get(context).uptadetask(0,
                                  TasksBloc.get(context).tasks[index]['id'],
                                  'UnCompelete'
                                  );
                                 }
                            },
                            checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(color: Colors.white)
                            ) ,
                            side: MaterialStateBorderSide.resolveWith((Set<MaterialState> states) {
                                    if (states.contains(MaterialState.selected)) {
                                      return const BorderSide(width: 2, color: Colors.white);
                                    }
                                    return null; // use the default for other states
                                  }),
                            //dense :true,
                            //scontentPadding: EdgeInsets.all(8),
                          ),
                        ),
                      ),
                    );
                    } // 

                    else if (tasks[index]['date'] == 
                    DateFormat('dd-MM-yyyy').format(
                      TasksBloc.get(context).datetimeLineSelected)
                    ){
                    return ClipRect(clipBehavior: Clip.hardEdge,
                      child: Container(margin: const EdgeInsets.only(bottom: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: colors[index % colors.length],
                        ),
                        child: Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.white),
                          child: CheckboxListTile(
                            title:Text(TasksBloc.get(context).tasks[index]['startTime'],
                            style: const TextStyle(color: Colors.white,fontSize: 14),),
                            subtitle: Text(TasksBloc.get(context).tasks[index]['title'],
                            style: const TextStyle(color: Colors.white),),
                            activeColor: Colors.transparent,
                            //selectedTileColor: Colors.green,
                            value: TasksBloc.get(context).tasks[index]['isChecked'] == 0 ?false:true,
                            onChanged: ( bool? value) { 
                              if(TasksBloc.get(context).tasks[index]['isChecked'] == 0){
                                 TasksBloc.get(context).uptadetask(1,
                                  TasksBloc.get(context).tasks[index]['id'],
                                  'Compelete'
                                  );
                                 }else{
                                 TasksBloc.get(context).uptadetask(0,
                                  TasksBloc.get(context).tasks[index]['id'],
                                  'UnCompelete'
                                  );
                                 }
                            },
                            checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(color: Colors.white)
                            ) ,
                            side: MaterialStateBorderSide.resolveWith((Set<MaterialState> states) {
                                    if (states.contains(MaterialState.selected)) {
                                      return const BorderSide(width: 2, color: Colors.white);
                                    }
                                    return null; // use the default for other states
                                  }),
                            //dense :true,
                            //scontentPadding: EdgeInsets.all(8),
                          ),
                        ),
                      ),
                    );
                    
                    }else{
                      return const AbsorbPointer(
                         absorbing: false, child: SizedBox( 
                          child: null,height: 0, width: 0,));
                    }  
                  }
                //, separatorBuilder: (BuildContext context, int index) {
                //   return const SizedBox(height: 0,); },
                ),
        );
      }
              
    );
  }
}