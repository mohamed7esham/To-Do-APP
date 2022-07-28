// ignore_for_file: unused_import
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'core/util/block/task/cubit.dart';
import 'features/Add_task/presentation/page/add_task_page.dart';
import 'features/Board/presentation/page/board_page.dart';
import 'features/Shedule/presesntation/page/shedule_page.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'services/notification_service/local_notification_service.dart';
 
void main() {

  // to ensure all the widgets are initialized.
  WidgetsFlutterBinding.ensureInitialized();
   
  // to initialize the notificationservice.
  LocalNotificationService().intialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {

        return MultiBlocProvider(
          providers: [
        BlocProvider<TasksBloc>(
          create: (context) => TasksBloc()..initDatabase(),
        ),
      ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            // You can use the library anywhere in the app even in theme
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          ),
        );
      },
      // ignore: prefer_const_constructors
      child: BoardPage(),
    );
  }
}

