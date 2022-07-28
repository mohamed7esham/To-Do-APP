import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/block/task/cubit.dart';
import '../../../../core/util/block/task/states.dart';
import '../../../../core/util/widgets/reusable_app_bar.dart';
import 'package:intl/intl.dart';
import '../widgets/task_list_per_day.dart';

class ShedulePage extends StatefulWidget {
  const ShedulePage({super.key});

  @override
  State<ShedulePage> createState() => _ShedulePageState();
}

class _ShedulePageState extends State<ShedulePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksStates>(
      listener: (context, state) {},
      builder: (context, state){
        return Scaffold(
        backgroundColor: Colors.white,
        appBar: const SimpleReusableAppBar(title: 'Shedule',),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 20, 26, 19),
                child: DatePicker(
                  DateTime.now(),
                  initialSelectedDate:DateTime.now(),
                  daysCount: 365,
                  width: 60,
                  height: 80,
                  dateTextStyle: const TextStyle(fontSize: 14,),
                  selectionColor: const Color(0xFF25c06d),
                  onDateChange: (date){
                    TasksBloc.get(context).onSelectedDateTimeline(date);
                  },
                ),
              ),
              Container(
              width: double.infinity,
              height: 1.2,
              color: const Color(0xFFf1f1f1),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 20, 26, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('EEEE').format(TasksBloc.get(context).datetimeLineSelected)),
                      Text(DateFormat('dMMMM, y').format(TasksBloc.get(context).datetimeLineSelected)),
                    ]
                  ),
                  const SizedBox(height: 20,),
                  const TaskListPerDay(),
                ],
              ),
            ),
            ],
          ),
        ),
      );
      }
      
    );
  }
}