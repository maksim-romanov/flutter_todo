import 'package:flutter/material.dart';

const initialTitle = 'Unnamed Task';
const initialDescription = 'No Description Added';

class TaskCardWidget extends StatelessWidget {
  final String? title;
  final String? description;

  // const TaskCardWidget({Key? key}) : super(key: key);
  const TaskCardWidget({
    Key? key,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(bottom: 10.0),
            child: Text(
              title ?? initialTitle,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF211551),
              ),
            ),
          ),
          Text(
            description ?? initialDescription,
            style: const TextStyle(
              fontSize: 16.0,
              color: Color(0xFF86829D),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
