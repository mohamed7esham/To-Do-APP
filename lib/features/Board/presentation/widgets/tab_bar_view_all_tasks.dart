import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/util/block/task/cubit.dart';
import '../../../../core/util/block/task/states.dart';

class TabBarViewAllTasks extends StatefulWidget {
  const TabBarViewAllTasks({super.key});

  @override
  State<TabBarViewAllTasks> createState() => _TabBarViewAllTasksState();
}

class _TabBarViewAllTasksState extends State<TabBarViewAllTasks> {

    List<Color> colors = [Colors.red,const Color(0xFFff9d42),const Color(0xFFf9c50b),Colors.blue,];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //TasksBloc.get(context).getTasks;
        var tasks = TasksBloc.get(context).tasks;
        return RefreshIndicator(
          onRefresh: () async {
                    //TasksBloc.get(context).getTasks();
                    print(TimeOfDay.now().format(context));
                   TimeOfDay t = TimeOfDay.now();
                  final now = new DateTime.now();
                  var xx = new DateTime(now.year, now.month, now.day, t.hour, t.minute);
                   print(xx);
                   final timestamp1 = xx.millisecondsSinceEpoch;
                print('${(timestamp1/1000).round()} (milliseconds/1000)');
                print('${(timestamp1/1000).round()-timestamp1/1000 } ');
                //var myDateTime = DateFormat('dd-MM-yyyy').format(timestamp1().toString());
                  },
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index){
            return Row(
              children: [
                Checkbox(
                    value: TasksBloc.get(context).tasks[index]['isChecked'] == 0 ?false:true,
                    side: BorderSide(color: colors[index % colors.length]),
                    activeColor: colors[index % colors.length],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),),

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
                    }
                ),
                Flexible(
                  child: Text(TasksBloc.get(context).tasks[index]['title'],
                  overflow: TextOverflow.visible,
                  softWrap: true)
                ),
                PopupMenuButton(itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'Compelete',
                  child: Text('Compelete'),
                  ),
                const PopupMenuItem(
                  value: 'UnCompelete',
                  child: Text('UnCompelete'),
                  ),
                const PopupMenuItem(
                  value: 'Favorite',
                  child: Text('Favorite'),
                  ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('delete'),
                  ),
                ],
                onSelected: (value){
                  TasksBloc.get(context).selectedPopupMenuItem = value;
                  TasksBloc.get(context).selectePopupMenuItem(
                    TasksBloc.get(context).tasks[index]['id']);
                  //TasksBloc.get(context).getTasks();
                },
                )
              ],
            );
          }, separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 12,); },
              itemCount: tasks.length),
              ),
        );
      }
      
    );
  }
}