import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../block/task/cubit.dart';
import '../block/task/states.dart';
import '/core/functions.dart';
class DateTimeWidget extends StatefulWidget {
  
  final double width;
  final IconData iconName;
  final double iconWidth;
   const DateTimeWidget({super.key,  this.width = double.infinity, 
   this.iconName =Icons.access_time_rounded, 
    this.iconWidth = 18.0,});

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  String? selectedDate;
// DateTime currentDate = DateTime.now();
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: currentDate,
//         firstDate: DateTime(2020),
//         lastDate: DateTime(2030));
//     if (pickedDate != null && pickedDate != currentDate) {
//               setState(() {
//         currentDate = pickedDate;
//         print(DateFormat('dd-MM-yyyy').format(currentDate));
//       });
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksStates>(
      listener: (context, state) {},
      builder: (context, state){
        return GestureDetector(
        onTap: () {
           //setState(() {
            TasksBloc.get(context).selectDate(context);
          // showDatePicker(
          // context: context,
          // initialDate: DateTime.now(),
          // firstDate: DateTime(2015),
          // lastDate: DateTime(2050)).then((value) => 
          // selectedDate = DateFormat('dd-MM-yyyy').format(value!));
          // });
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
                TasksBloc.get(context).selectedDate??DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
                //DateFormat('dd-MM-yyyy').format(TasksBloc.get(context).currentDate).toString(),
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