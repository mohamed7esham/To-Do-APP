import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/block/task/cubit.dart';
import '../../../../core/util/block/task/states.dart';

class TabBarViewCompletedTasks extends StatefulWidget {
  const TabBarViewCompletedTasks({super.key});

  @override
  State<TabBarViewCompletedTasks> createState() => _TabBarViewCompletedTasksState();
}

class _TabBarViewCompletedTasksState extends State<TabBarViewCompletedTasks> {

    List<Color> colors = [Colors.red,const Color(0xFFff9d42),const Color(0xFFf9c50b),Colors.blue,];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TasksBloc.get(context).completedTasks;
        return RefreshIndicator(
          onRefresh: () async {
                    //TasksBloc.get(context).getCompleteTasks();
                  },
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index){
            return Row(
              children: [
                Checkbox(
                    value: TasksBloc.get(context).completedTasks[index]['isChecked'] == 0 ?false:true,
                    side: BorderSide(color: colors[index % colors.length]),
                    activeColor: colors[index % colors.length],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),),

                    onChanged: ( bool? value) {
                      if(TasksBloc.get(context).completedTasks[index]['isChecked'] == 0){
                      TasksBloc.get(context).uptadetask(1,
                       TasksBloc.get(context).completedTasks[index]['id'],
                       'Compelete'
                       );
                      }else{
                      TasksBloc.get(context).uptadetask(0,
                       TasksBloc.get(context).completedTasks[index]['id'],
                       'UnCompelete'
                       );
                      }
                    }
                ),
                Flexible(
                  child: Text(TasksBloc.get(context).completedTasks[index]['title'],
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
                    TasksBloc.get(context).completedTasks[index]['id']);
                  //TasksBloc.get(context).getTasks();
                },
                )
              ],
            );
          }, separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 12,); },
              itemCount: TasksBloc.get(context).completedTasks.length),
              ),
        );
      }
      
    );
  }
}