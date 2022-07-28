
import 'package:flutter/material.dart';
import '../../../Add_task/presentation/page/add_task_page.dart';

class FooterButton extends StatelessWidget {
  const FooterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 10, 26, 10),
          child: ClipRRect(borderRadius: BorderRadius.circular(15),
            child: SizedBox(height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF25c06d),
                ),
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddTaskPage()),);
                },
                child: const Text('Add a Task'),
              ),
            ),
          ),
        ),
       );
  }
}