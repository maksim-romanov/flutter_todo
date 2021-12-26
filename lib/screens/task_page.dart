import 'package:flutter/material.dart';
import 'package:todo/helpers/database.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/widgets/todo_item_widget.dart';

class TaskPage extends StatefulWidget {
  final Task? task;
  const TaskPage({Key? key, this.task}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _databaseHelper = DatabaseHelper();
  String _tastTitle = '';
  int _taskId = 0;

  @override
  void initState() {
    if (widget.task != null) {
      _tastTitle = widget.task?.title ?? '';
      _taskId = widget.task?.id ?? 0;
    }

    super.initState();
  }

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
                            if (widget.task != null) {
                              print('Update Task');
                              return;
                            }

                            await _databaseHelper.insertTask(Task(title: titleValue));
                          },
                          style: const TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF211551),
                          ),
                          controller: TextEditingController()..text = _tastTitle,
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
                  // const SizedBox(height: 10),
                  FutureBuilder<List<Todo>>(
                    future: _databaseHelper.getTodos(_taskId),
                    builder: (context, snapshot) => Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final todo = snapshot.data?[index];
                          if (todo == null) return const Text('not found');

                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // make is done
                                },
                                child: TodoItemWidget(
                                  text: todo.title,
                                  isDone: todo.isDone == 1,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20.0,
                        height: 20.0,
                        margin: const EdgeInsets.only(right: 12.0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(width: 1.5, color: const Color(0xFF86829d)),
                        ),
                        child: const Image(
                          image: AssetImage('assets/images/check_icon.png'),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onSubmitted: (todoTitle) async {
                            final task = widget.task;

                            if (todoTitle == '') return;
                            if (task == null) {
                              print('Create Task');
                              return;
                            }
                            await _databaseHelper.insertTodo(Todo(title: todoTitle, taskId: _taskId));
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter Todo item...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  )
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
