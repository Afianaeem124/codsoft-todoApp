import 'package:flutter/material.dart';
import 'package:todoapp/model/modeltodo.dart';
import 'package:todoapp/widgets/todo_item.dart';
import '../constants/colors.dart';

class Todohome extends StatefulWidget {
  const Todohome({super.key});

  @override
  State<Todohome> createState() => _TodohomeState();
}

class _TodohomeState extends State<Todohome> {
  //--------------------------------------------------
  final todolist = ToDo.todoList();
  final todocontroller = TextEditingController();
  List<ToDo> foundtodo = [];

  @override
  void initState() {
    foundtodo = todolist;
    super.initState();
  }

  //-----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      appBar: buildappbar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(children: [
              searchbox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          'ALL ToDos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                    for (ToDo todo in foundtodo.reversed)
                      todoitem(
                        todo: todo,
                        ontodochanged: handletodochange,
                        ondeleteitem: _deleteToDoItem,
                      )
                  ],
                ),
              ),
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: todocontroller,
                    decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    onPressed: () {
                      addtodoitem(todocontroller.text);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: tdBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize: Size(60, 60),
                        elevation: 10),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

//-----------------------------------------------------------
  void handletodochange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todolist.removeWhere((item) => item.id == id);
    });
  }

  void addtodoitem(String todoo) {
    setState(() {
      todolist.add(ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: todoo));
      todocontroller.clear();
    });
  }

  void foundtd(String kw) {
    List<ToDo> results = [];
    if (kw.isEmpty) {
      results = todolist;
    } else {
      results = todolist
          .where(
              (item) => item.todoText!.toLowerCase().contains(kw.toLowerCase()))
          .toList();
    }
    setState(() {
      foundtodo = results;
    });
  }

//------------------------------------------------------------------------------------------------------------------------
  Widget searchbox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
          //onChanged: (value)=> foundtd(value),
          onChanged: (value) => foundtd(value),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey),
          )),
    );
  }

  AppBar buildappbar() {
    return AppBar(
      backgroundColor: tdWhite,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(Icons.menu, color: tdBlack, size: 30),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/avt.png')),
        )
      ]),
    );
  }
}
