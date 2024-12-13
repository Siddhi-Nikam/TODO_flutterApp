import 'package:flutter/material.dart';

class TodoList extends StatefulWidget{
  const TodoList({super.key});

  @override
  State<StatefulWidget> createState() {
    return  _TodoListState();
  }

}

class _TodoListState extends State{
  final TextEditingController _textFieldController = TextEditingController();
  final List<Todo> _todos = <Todo>[];
  _displayDialog(){
    showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
              title: const Text('Add a new todo item'),
              content: TextField(
                controller: _textFieldController,
                decoration: const InputDecoration(hintText: 'Add New Task'),
              ),
            actions: [
              TextButton(
                  child: const Text("Add"),
                onPressed: (){
                    Navigator.of(context).pop();
                    _addTodoItem(_textFieldController.text);
                },

              ),
              TextButton(
                child: Text("Cancel"),
                onPressed: (){
                 Navigator.pop(context);

                },

              )
            ],

          );
        }
    );
  }
  _addTodoItem(String name){
    setState(() {
      _todos.add(Todo(name: name, checked: false));
    });
    _textFieldController.clear();
  }


  _handleTodoChange(Todo todo){

   setState(() {
     todo.checked = !todo.checked;
   });

  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.purpleAccent.shade100,
    appBar: AppBar(
      title: Text("TODO LIST",style: TextStyle(fontWeight: FontWeight.bold),),
      backgroundColor: Colors.purpleAccent,
    ),
    body: ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      children: _todos.map((Todo todo) {
        return TodoItem(
          todo: todo,
          onTodoChanged: _handleTodoChange,

        );
      }).toList(),
    ),


    floatingActionButton: Container(
      margin: EdgeInsets.only(right: 150),
      child: FloatingActionButton(
          onPressed: () => _displayDialog(),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    ),
  );
  }

  }



class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}
class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
    this.deleteitem,

  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final onTodoChanged;
  final deleteitem;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return TextStyle(fontSize: 20);

    return TextStyle(
      fontSize: 20,
      color: Colors.purple,
      decoration: TextDecoration.lineThrough,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),

      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(12)
        ),
        child: ListTile(
          onTap: () {
            onTodoChanged(todo);
          },
          leading: CircleAvatar(
            backgroundColor: Colors.purpleAccent.shade100,
            child: Text(todo.name[0], style: TextStyle(fontSize: 20),),
          ),
          title: Text(todo.name, style: _getTextStyle(todo.checked)),

      ),
      )
    );
  }
}

