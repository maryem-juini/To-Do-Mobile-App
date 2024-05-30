import 'package:flutter/material.dart';
import 'package:workshop/add_task.dart';
import 'package:workshop/task.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

int counter = 0;

class _TasksState extends State<Tasks> {
  List<Task> list = [
    Task("Cleaning", false),
    Task("Studying", false),
    Task("Family", false),
  ];

  void AddTask(Task task) {
    setState(() {
      list.add(task);
    });
  }

  void RemoveTask(Task task) {
    setState(() {
      list.remove(task);
    });
  }

  void Celebrate() {
    setState(() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "YAAAAY",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            content: Container(
              height: 300,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.all(10.0),
                      child: Image(image: AssetImage("assets/cuty.gif"))),
                  Text(
                    "YOU FINISHED ALL YOUR TASKS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("To Do App")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Add_Task(onAddedTask: AddTask)),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 212, 228, 246),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Checkbox(
                        value: list[index].isCompleted,
                        onChanged: (value) {
                          setState(() {
                            list[index].isCompleted = !list[index].isCompleted;
                            if (list[index].isCompleted == true) {
                              counter++;
                              if (counter == list.length) Celebrate();
                            }
                          });
                        },
                      ),
                      Text(list[index].title,
                          style: list[index].isCompleted
                              ? TextStyle(
                                  decoration: TextDecoration.lineThrough)
                              : TextStyle(decoration: TextDecoration.none)),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          RemoveTask(list[index]);
                        },
                        icon: Icon(Icons.delete),
                        color: Color.fromARGB(255, 78, 74, 74),
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
