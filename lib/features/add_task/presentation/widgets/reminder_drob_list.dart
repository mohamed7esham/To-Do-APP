import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/block/task/cubit.dart';
import '../../../../core/util/block/task/states.dart';

class RminderDropList extends StatefulWidget {
  const RminderDropList({super.key});

  @override
  State<RminderDropList> createState() => _RminderDropListState();
}

class _RminderDropListState extends State<RminderDropList> {
  //  String? reminderValue = '10m';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksStates>(
      listener: (context, state) {},
      builder: (context, state){
       return Container(
               width: double.infinity,
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
                 value: TasksBloc.get(context).reminderValue,
                 items: const [
                 DropdownMenuItem(value: '10m', child: Text('10 min before')),
                 DropdownMenuItem(value: '30m', child: Text('30 min before')),
                 DropdownMenuItem(value: '1h', child: Text('1 hour before')),
                 DropdownMenuItem(value: '1d', child: Text('1 day before')),
                 ],
                 onChanged: (value) { 
                    //setState(() {
                      TasksBloc.get(context).onSelectedReminderValue(value??'10m');
                    //});
                  },
                //  onChanged: dropdownCallBack,
                // value: _dropdownValue,
               ),
            );
      }
    );
  }
}