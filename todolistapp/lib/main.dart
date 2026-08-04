import 'package:flutter/material.dart';
import 'package:todolistapp/database/todo_database.dart';
import 'package:todolistapp/model/todo.dart';
import 'package:todolistapp/screens/detail_screen.dart';
import 'package:todolistapp/screens/form_screen.dart';
import 'package:todolistapp/utils/helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late TodoDatabase todoDatabase;
  List<Todo> listTodo = [];
  bool isLoading = false;
  int? selectedTodoId;

  @override
  void initState() {
    super.initState();
    todoDatabase = TodoDatabase();

    getListTodo();
  }

  void getListTodo() async {
    isLoading = true;
    await todoDatabase.getAllTodo()
      .then((value){
        listTodo = value;
      })
      .catchError((err){
        Helper.showSnackbar(context, "Error saat menampilkan data $err");
      })
      .whenComplete((){
        setState(() {
          isLoading = false;
        });
      });
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenOrientation = MediaQuery.of(context).orientation;
    Widget body;

    if(screenWidth > 600 && screenOrientation == Orientation.landscape){
      body = Row (
        children: [
          SizedBox(
            width: screenWidth / 3, child:
            buildListTodo(
              selectedId: (id) {
                setState(() {
                  selectedTodoId = id;
                });
              }
            )
          ),
          Expanded(
            child: selectedTodoId == null
            ? Center(child: Text("Pilih data terlebih dahulu"))
            : DetailScreen(
              id: selectedTodoId!,
              isLandscape: true,
              onDeleted: (){
                setState(() {
                  selectedTodoId = null;
                  getListTodo();
                });
              },
            )
          )
        ],
      );
    } else {
      body = buildListTodo(
        selectedId: (id) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(id: id, isLandscape: false,))
          )
          .then((value) {
            if(value == Helper.NEED_REFRESH){
              getListTodo();
            }
          });
        }
      );
    }


  
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Center(
          child: Text("Todo List"),
        ),
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormScreen() 
            )
          ).then((value){
            if(value == Helper.NEED_REFRESH){
              getListTodo();
              debugPrint("Getting new data...");
            }
          });
        },
        tooltip: 'Tambah todo',
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget buildListTodo({required void Function (int id) selectedId}){
    return  Center(
       child: isLoading 
        ? CircularProgressIndicator()
        : listTodo.isEmpty 
        ? Text("Belum ada data")
        : ListView.builder(
          itemCount: listTodo.length,
          itemBuilder: (context, index){
            final todo = listTodo[index];
            return GestureDetector(
              child: cardTodo(todo),
              onTap: (){
                selectedId(todo.id ?? 0);

                
              },

              );
          }
        ),
      );
  }

  /// tampilkan card/kotak data
  Widget cardTodo(Todo todo){
    return GestureDetector(

      child: Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((todo.id ?? 0).toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      todo.title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  todo.isCompleted
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : Icon(
                    Icons.do_not_disturb_on_rounded,
                    color: Colors.orange,
                  ),
                ],
              ),
              Text("Kategori: ${todo.category}", style: TextStyle(fontSize: 20)),
              Text("Prioritas: ${todo.priority}", style: TextStyle(fontSize: 20)),
              Text("Hari: ${todo.days}", style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }

}
