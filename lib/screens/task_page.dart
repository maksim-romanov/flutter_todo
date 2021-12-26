import 'package:flutter/material.dart';
import 'package:todo/helpers/database.dart';
import 'package:todo/models/task.dart';
import 'package:todo/widgets/todo_item_widget.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF6F6F6),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Image(image: AssetImage('assets/images/back_arrow_icon.png')),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          // autofocus: true,
                          onSubmitted: (titleValue) async {
                            if (titleValue == '') return;
                            final DatabaseHelper _databaseHelper = DatabaseHelper();
                            await _databaseHelper.insertTask(Task(title: titleValue));
                          },
                          style: const TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF211551),
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Enter Task Title',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Description for the task...',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TodoItemWidget(
                    text: 'Create your first task',
                    isDone: false,
                  ),
                  const SizedBox(height: 10),
                  const TodoItemWidget(isDone: true),
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    print('Delete todo list');
                  },
                  child: Container(
                    // padding: const EdgeInsets.all(10.0),
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFfe3577),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Image(
                      image: AssetImage('assets/images/delete_icon.png'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
