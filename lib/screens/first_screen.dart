import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/widgets/todolist.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final todoslist = ToDo.todolist();
  final _ToDoController = TextEditingController();
  List<ToDo> _foundtodo = [];
  @override
  void initState() {
    _foundtodo = todoslist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.tdGrey,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(60.0), // Adjust the height as needed
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
          child: _buildappbar(),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Searchbox(),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      child: Text(
                        'WE CAN DO THIS ALL DAY!!!',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    for (ToDo todoo in _foundtodo.reversed)
                      ToDoList(
                        todo: todoo,
                        onhandleToDochange: _handleToDochange,
                        onToDodelete: _deleteToDoitem,
                      ),
                  ],
                )),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        margin: EdgeInsets.only(bottom: 5, right: 20, left: 20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 110, 185, 247),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(0, 0))
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: TextField(
                            controller: _ToDoController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Add Your ToDo...',
                                hintStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5, right: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          _addToDoitem(_ToDoController.text);
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 110, 185, 247),
                            elevation: 10,
                            minimumSize: Size(40, 40)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDochange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoitem(String id) {
    setState(() {
      todoslist.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoitem(String Todo) {
    setState(() {
      todoslist.add(ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          ToDoText: Todo));
    });
    _ToDoController.clear();
  }

  void _searchFilter(String enterdkeyword) {
    List<ToDo> results = [];
    if (enterdkeyword.isEmpty) {
      results = todoslist;
    } else {
      results = todoslist
          .where((item) => item.ToDoText!
              .toLowerCase()
              .contains(enterdkeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundtodo = results;
    });
  }

  Widget Searchbox() {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: TextField(
            onChanged: (value) => _searchFilter(value),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 20,
                  minWidth: 25,
                ),
                hintText: 'Search..',
                hintStyle: TextStyle(color: Colors.grey)),
          ),
        ));
  }

  AppBar _buildappbar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colours.tdGrey,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: Colors.black,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profiletodo.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ));
  }
}
