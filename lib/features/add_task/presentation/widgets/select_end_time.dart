import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:intl/intl.dart';
import '../../../../core/util/block/task/cubit.dart';
import '../../../../core/util/block/task/states.dart';
import '/core/functions.dart';
class EndTimeWidget extends StatefulWidget {

  final double width;
  final IconData iconName;
  final double iconWidth;
   const EndTimeWidget({super.key,  this.width = double.infinity, 
   this.iconName =Icons.access_time_rounded, 
    this.iconWidth = 18.0,});

  @override
  State<EndTimeWidget> createState() => _EndTimeWidgetState();
}

class _EndTimeWidgetState extends State<EndTimeWidget> {
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksStates>(
      listener: (context, state) {},
      builder: (context, state){
        return GestureDetector(
        onTap: () {
          //setState(() {
            TasksBloc.get(context).selectEndTime(context);
          //});
        },
        child: Container(
          width: widget.width,
          height: 45.0,
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8.5),
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text(
                TasksBloc.get(context).selectedEndTime??
                TimeOfDay.now().format(context).toString(),
               // currentTime.format(context).toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
               Icon(
                widget.iconName,
                color: Colors.grey,
                size: widget.iconWidth,
              ),
            ],
          ),
        ),
      );
      }
       
    );
  }
}