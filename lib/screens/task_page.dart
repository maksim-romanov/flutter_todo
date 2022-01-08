import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/helpers/database.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/widgets/todo_item_widget.dart';

import 'home_page.dart';

class TaskPage extends StatefulWidget {
  final Task? task;
  const TaskPage({Key? key, this.task}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _todoFocus;

  final _databaseHelper = DatabaseHelper();

  bool _contentVisible = false;
  int _taskId = -1;
  String _taskTitle = '';
  String _taskDescription = '';

  @override
  void initState() {
    if (widget.task != null) {
      _contentVisible = true;

      _taskTitle = widget.task?.title ?? '';
      _taskDescription = widget.task?.description ?? '';
      _taskId = widget.task?.id ?? 0;
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  Future<void> switchTodo(Todo todo) async {
    if (todo.id == null) return;

    await _databaseHelper.updateTodoDone(todo.id ?? -1, todo.isDone == 1 ? 0 : 1);
    setState(() {});
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();

    super.dispose();
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
                          focusNode: _titleFocus,
                          onSubmitted: (titleValue) async {
                            if (titleValue == '') return;

                            if (widget.task != null || _taskId != -1) {
                              await _databaseHelper.updateTaskTitle(_taskId, titleValue);
                              _descriptionFocus.requestFocus();
                              return;
                            }

                            _taskId = await _databaseHelper.insertTask(Task(title: titleValue));
                            _descriptionFocus.requestFocus();
                            setState(() {
                              _taskTitle = titleValue;
                              _contentVisible = true;
                              _taskId = _taskId;
                            });
                          },
                          style: const TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF211551),
                          ),
                          controller: TextEditingController()..text = _taskTitle,
                          decoration: const InputDecoration(
                            hintText: 'Enter Task Title',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 20),
                  Visibility(
                    visible: _contentVisible,
                    child: TextField(
                      focusNode: _descriptionFocus,
                      onSubmitted: (value) async {
                        if (value == '') return;
                        if (widget.task == null && _taskId == -1) return;
                        await _databaseHelper.updateTaskDescription(_taskId, value);
                        _todoFocus.requestFocus();
                      },
                      controller: TextEditingController()..text = _taskDescription,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Description for the task...',
                      ),
                    ),
                  ),
                  // const SizedBox(height: 10),
                  Visibility(
                    visible: _contentVisible,
                    child: FutureBuilder<List<Todo>>(
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
                                  onTap: () async {
                                    final _todo = snapshot.data?[index];
                                    if (_todo == null) return;

                                    switchTodo(_todo);
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
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Row(
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
                            focusNode: _todoFocus,
                            controller: TextEditingController()..text = '',
                            onSubmitted: (todoTitle) async {
                              if (todoTitle == '') return;
                              await _databaseHelper.insertTodo(Todo(title: todoTitle, taskId: _taskId));
                              _todoFocus.requestFocus();
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter Todo item...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Visibility(
                visible: _contentVisible,
                child: Positioned(
                  bottom: 24.0,
                  right: 0.0,
                  child: GestureDetector(
                    onTap: () async {
                      if (_taskId == -1) return;
                      await _databaseHelper.deleteTask(_taskId);
                      Navigator.pop(context);
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
