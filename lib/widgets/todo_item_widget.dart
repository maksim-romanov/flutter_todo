import 'package:flutter/material.dart';

class TodoItemWidget extends StatelessWidget {
  final String? text;
  final bool isDone;

  const TodoItemWidget({
    Key? key,
    this.text,
    this.isDone = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              color: isDone ? const Color(0xFF7349fe) : Colors.transparent,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                width: 1.5,
                color: isDone ? const Color(0xFF7349fe) : const Color(0xFF86829d),
              ),
            ),
            child: const Image(
              image: AssetImage('assets/images/check_icon.png'),
            ),
          ),
        ),
        Flexible(
          child: Text(
            text ?? '(Unnamed Todo)',
            style: TextStyle(
              color: isDone ? const Color(0xFF211551) : const Color(0xFF86829d),
              fontSize: 16.0,
              fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        )
      ],
    );
  }
}
