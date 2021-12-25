import 'package:flutter/material.dart';
import 'package:todo/widgets/task_card_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF6F6F6),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 32.0,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: const Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                  const TaskCardWidget(
                    title: 'Get Started',
                    description:
                        'Hello User! Welcome to WHAT_TODO app, this is a default task that you can edit or delete to start using the app.',
                  ),
                  const TaskCardWidget(),
                ],
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  // padding: const EdgeInsets.all(10.0),
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7248fc),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Image(
                    image: AssetImage('assets/images/add_icon.png'),
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
