import 'package:flutter/material.dart';
// import 'package:flutter_local_notification/screens/second_screen.dart';
// import 'package:flutter_local_notification/services/local_notification_service.dart';
import 'package:to_do_app/features/Shedule/presesntation/page/shedule_page.dart';
import 'package:to_do_app/services/notification_service/local_notification_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notification Demo'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'only for test test\n test test test',
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showNotification(
                          id: 0,
                          title: 'Notification Title',
                          body: 'Some body');
                    },
                    child: const Text('Show Local Notification'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showScheduledNotification(
                         0,
                         'Notification Title',
                         'Some body',
                         4,
                      );
                    },
                    child: const Text('Show Scheduled Notification'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showNotificationWithPayload(
                          id: 0,
                          title: 'Notification Title',
                          body: 'Some body',
                          payload: 'payload navigation');
                    },
                    child: const Text('Show Notification With Payload'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void listenToNotification() =>
  //     service.onNotificationClick.stream.listen(onNoticationListener);

  // void onNoticationListener(String? payload) {
  //   if (payload != null && payload.isNotEmpty) {
  //     print('payload $payload');

  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: ((context) => ShedulePage(payload: payload))));
  //   }
  // }
}

