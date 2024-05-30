import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workshop/task.dart';
import 'package:http/http.dart' as http;

class Add_Task extends StatefulWidget {
  final Function(Task) onAddedTask;
  const Add_Task({super.key, required this.onAddedTask});

  @override
  State<Add_Task> createState() => Add_TaskState();
}

class Add_TaskState extends State<Add_Task> {
  TextEditingController mycontroller = TextEditingController();
  String quote = '';
  Future getQuote() async {
    var response = await http.get(Uri.https('api.quotable.io', 'random'));
    var json = jsonDecode(response.body);
    quote = json['content'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: FutureBuilder(
        future: getQuote(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      controller: mycontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Add Task',
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.onAddedTask(Task(mycontroller.text, false));
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Text(
                        "Confirmer",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    height:50,
                  ),
                  Container(
                    height: 120,
                    child: Image.asset("assets/finalcat.png")),
                  Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
                      padding: EdgeInsets.all(20.0),
                      height: 200,  
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 169, 224, 250),
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text("Boost Your Productivity With A Touch Of Wisdom",style: 
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color : Color.fromARGB(255, 183, 18, 51)
                          ),),
                          SizedBox(
                            height: 40,
                          ),
                          Text(quote,style: TextStyle(
                            color:Colors.black 
                          ),)
                        ],
                      ))
                ],
              ),
            );
          } else
            return Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
        },
      ),
    );
  }
}
