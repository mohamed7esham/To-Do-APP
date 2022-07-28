import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/features/Board/presentation/page/board_page.dart';
import '../../../../core/util/block/task/cubit.dart';
import '../../../../core/util/block/task/states.dart';
import '../../../../core/util/widgets/reusable_app_bar.dart';
import '../../../../core/util/widgets/reusable_button.dart';
import '../../../../core/util/widgets/reusable_date_time.dart';
import '../../../../core/util/widgets/reusable_label_txt_field.dart';
import '../../../../core/util/widgets/reusable_txt_form_field.dart';
import '../../../../services/notification_service/local_notification_service.dart';
import '../widgets/repeat_drop_list.dart';
import '../widgets/reminder_drob_list.dart';
import '../widgets/select_end_time.dart';
import '../widgets/select_start_time_widget.dart';

class AddTaskPage extends StatefulWidget {
   const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    //listenToNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksStates>(
      listener: (context, state) {},
      builder: (context, state){
        return Scaffold(
        backgroundColor: Colors.white,
        appBar: const SimpleReusableAppBar(title: 'Add task',),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 16, 30, 0,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:   [
                const ReusableLabelText(label: 'Title',),
                const SizedBox(height: 8,),
                 ResuableTextFormField(hintTextt: 'Enter text..',
                 txtfield:TasksBloc.get(context).textEditingController),
                const SizedBox(height: 26,),
                const ReusableLabelText(label: 'Date',),
                const SizedBox(height: 8,),
                 const DateTimeWidget(iconName: Icons.keyboard_arrow_down,iconWidth: 26,),
                const SizedBox(height: 26,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ReusableLabelText(label: 'Start time',),
                          const SizedBox(height: 8,),
                          StartTimeWidget(width: 140.w),
                          ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ReusableLabelText(label: 'End time',),
                          const SizedBox(height: 8,),
                          EndTimeWidget(width: 140.w),
                          ],
                      ),
                    ],
                ),
                const SizedBox(height: 26,),
                const ReusableLabelText(label: 'Reminder',),
                const SizedBox(height: 8,),
    
                const RminderDropList(),
    
                const SizedBox(height: 26,),
                const ReusableLabelText(label: 'Repeat',),
                const SizedBox(height: 8,),
    
                const RepeatDropList(),
    
                  SizedBox(height: 66.h,),
                  MainButton(
                    buttonColor: const Color(0xFF25c06d), height: 45,
                    radius: 15,
                    text: 'Create a Task',
                    onClick: () async{
                      TasksBloc.get(context)
                         .insertData(
                          TasksBloc.get(context).textEditingController
                          .text.toString(),
                          TasksBloc.get(context).selectedDate??DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
                          TasksBloc.get(context).selectedStartTime??TimeOfDay.now().format(context).toString(),
                          TasksBloc.get(context).selectedEndTime??TimeOfDay.now().format(context).toString(),
                          TasksBloc.get(context).reminderValue??'10m',
                          TasksBloc.get(context).repratedValue??'Weekly',
                          TasksBloc.get(context).isCompleted,
                          TasksBloc.get(context).status,
                        );
                        TasksBloc.get(context).xy(context);
                        TasksBloc.get(context).textEditingController
                            .text='';
                            TasksBloc.get(context).selectedDate= DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
                            // TasksBloc.get(context).deleteAll();

                            
                            await service.showScheduledNotification(
                            0,
                            TasksBloc.get(context).textEditingController.text.toString(),
                            'your task has started',
                            TasksBloc.get(context).duration.toInt(),
                            );


                        Navigator.pop(context);
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const BoardPage()));
                    },
                  ),
                  SizedBox(height: 16.h,),
              ],
            ),
          ),
        ),
      );
      }
      
    );
  }
}