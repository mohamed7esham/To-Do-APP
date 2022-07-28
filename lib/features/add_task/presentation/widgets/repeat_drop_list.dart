
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/block/task/cubit.dart';
import '../../../../core/util/block/task/states.dart';

class RepeatDropList extends StatefulWidget {
  const RepeatDropList({super.key});

  @override
  State<RepeatDropList> createState() => _RepeatDropListState();
}

class _RepeatDropListState extends State<RepeatDropList> {
  //String? repratedValue = 'Weekly';
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<TasksBloc, TasksStates>(
      listener: (context, state) {},
      builder: (context, state){
        return Container(
                width: double.infinity,
                //height: 45.0,
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                decoration: BoxDecoration(
                 color: Colors.grey[100],
                 borderRadius: BorderRadius.circular(8.5),
                 border: Border.all(
                  color: Colors.transparent,
                 ),
                ),
                child: DropdownButton(
                  style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                  isExpanded : true,
                   icon: const Icon(Icons.keyboard_arrow_down),
                   underline: const SizedBox(),
                   value: TasksBloc.get(context).repratedValue,
                  items: const [
                  DropdownMenuItem(value: 'Dayly', child: Text('dayly')),
                  DropdownMenuItem(value: 'Weekly', child: Text('weekly')),
                  ],
                  onChanged: (value) { 
                    //setState(() {
                      TasksBloc.get(context).onSelectedrepratedValue(value??'Weekly');
                   // });
                   },
                ),
              );
      }
    );
  }
}