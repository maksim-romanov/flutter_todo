import 'package:flutter/material.dart';
import 'package:todo/helpers/database.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screens/task_page.dart';
import 'package:todo/widgets/task_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// TaskCardWidget(
//   title: 'Get Started',
//   description:
//       'Hello User! Welcome to WHAT_TODO app, this is a default task that you can edit or delete to start using the app.',
// ),
class _HomePageState extends State<HomePage> {
  final _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          color: const Color(0xFFF6F6F6),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            // vertical: 32.0,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 24,
                      bottom: 32.0,
                    ),
                    child: const Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<Task>>(
                      future: _databaseHelper.getTasks(),
                      builder: (context, snapshot) => ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            final task = snapshot.data?[index];
                            if (task == null) return;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskPage(task: task),
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          child: TaskCardWidget(
                            // id: snapshot.data?[index].id,
                            title: snapshot.data?[index].title,
                            description: snapshot.data?[index].description,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskPage(),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    // padding: const EdgeInsets.all(10.0),
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      // color: const Color(0xFF7248fc),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7349FE), Color(0xFF643FDB)],
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, 1.0),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Image(
                      image: AssetImage('assets/images/add_icon.png'),
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
