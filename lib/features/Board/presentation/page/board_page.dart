import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/features/Shedule/presesntation/page/shedule_page.dart';
import '../../../../core/util/block/task/cubit.dart';
import '../../../../core/util/block/task/states.dart';
import '../../../../test_notf.dart';
import '../widgets/tab_bar_view_all_tasks.dart';
import '../widgets/customized_app_bar.dart';
import '../widgets/footer_button.dart';
import '../widgets/view_completed_task.dart';
import '../widgets/view_favorite_task.dart';
import '../widgets/view_unCompleted_task.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
         length: 4,
         child: Scaffold(
         backgroundColor: Colors.white,
          appBar: AppBar(
            shape: const Border(bottom: BorderSide(color: Color(0xFFf1f1f1))),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            title: const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Text('Board'),
            ),
            actions: [
              IconButton(padding: const EdgeInsets.only(right: 14),
                icon: const Icon(Icons.calendar_month_sharp),
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ShedulePage()),);
                },
              ),
              IconButton(padding: const EdgeInsets.only(right: 14),
                icon: const Icon(Icons.notifications_active_outlined),
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()),);
                },
              ),
            ],
            
            bottom:  const CustomizedTabBar()
          ),
          body: const TabBarView(
            children: [
              TabBarViewAllTasks(),
              TabBarViewCompletedTasks(),
              TabBarViewUnCompletedTasks(),
              TabBarViewFavouriteTasks(),
            ],
          ),
         bottomNavigationBar: const FooterButton(),
        ),
      );
      }
    );
  }
}