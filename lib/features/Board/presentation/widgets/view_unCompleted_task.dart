import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/block/task/cubit.dart';
import '../../../../core/util/block/task/states.dart';

class TabBarViewUnCompletedTasks extends StatefulWidget {
  const TabBarViewUnCompletedTasks({super.key});

  @override
  State<TabBarViewUnCompletedTasks> createState() => _TabBarViewUnCompletedTasksState();
}

class _TabBarViewUnCompletedTasksState extends State<TabBarViewUnCompletedTasks> {

    List<Color> colors = [Colors.red,const Color(0xFFff9d42),const Color(0xFFf9c50b),Colors.blue,];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //TasksBloc.get(context).getTasks;
        var tasks = TasksBloc.get(context).uncompletedTasks;
        return RefreshIndicator(
          onRefresh: () async {
                    TasksBloc.get(context).getTasks();
                  },
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index){
            return Row(
              children: [
                Checkbox(
                    value: TasksBloc.get(context).uncompletedTasks[index]['isChecked'] == 0 ?false:true,
                    side: BorderSide(color: colors[index % colors.length]),
                    activeColor: colors[index % colors.length],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),),

                    onChanged: ( bool? value) {
                      if(TasksBloc.get(context).uncompletedTasks[index]['isChecked'] == 0){
                      TasksBloc.get(context).uptadetask(1,
                       TasksBloc.get(context).uncompletedTasks[index]['id'],
                       'Compelete'
                       );
                      }else{
                      TasksBloc.get(context).uptadetask(0,
                       TasksBloc.get(context).uncompletedTasks[index]['id'],
                       'UnCompelete'
                       );
                      }
                    }
                ),
                Flexible(
                  child: Text(TasksBloc.get(context).uncompletedTasks[index]['title'],
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
                    TasksBloc.get(context).uncompletedTasks[index]['id']);
                  //TasksBloc.get(context).getTasks();
                },
                )
              ],
            );
          }, separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 12,); },
              itemCount: TasksBloc.get(context).uncompletedTasks.length),
              ),
        );
      }
      
    );
  }
}