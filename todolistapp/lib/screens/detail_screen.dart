
import 'package:flutter/material.dart';
import 'package:todolistapp/database/todo_database.dart';
import 'package:todolistapp/model/todo.dart';
import 'package:todolistapp/screens/form_screen.dart';
import 'package:todolistapp/utils/helper.dart';

class DetailScreen extends StatefulWidget {

  final int id;
  final bool isLandscape;
  final VoidCallback? onDeleted;
  const DetailScreen({
    super.key,
    required this.id,
    required this.isLandscape,
    this.onDeleted
  });


  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {


  late TodoDatabase todoDatabase;
  Todo? detailTodo;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    todoDatabase = TodoDatabase();
    getDetailTodo();
  }

  void getDetailTodo() async {
    isLoading = true;
    await todoDatabase.getTodoById(widget.id)
    .then((value){
      detailTodo = value;
    })
    .catchError((e){
      Helper.showSnackbar(context, "Error saat menampilkan data $e");
    })
    .whenComplete((){
      setState(() {
        isLoading = false;
      });
    });
  }


  @override
  void didUpdateWidget(covariant DetailScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (oldWidget.id != widget.id){
      getDetailTodo();
    }
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Todo"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => FormScreen(updateTodo: detailTodo) 
              ))
              .then((value){
                if(value == Helper.NEED_REFRESH){
                  getDetailTodo();
                }
              });
            },
            icon: Icon(Icons.edit)
          ),
          IconButton(
            onPressed: showConfirmDelete,
            icon: Icon(Icons.delete)
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      detailTodo?.title ?? "no title",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  detailTodo?.isCompleted == true
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : Icon(
                    Icons.do_not_disturb_on_rounded,
                    color: Colors.orange,
                  ),
                ],
              ),
              Text("Kategori: ${detailTodo?.category}", style: TextStyle(fontSize: 20)),
              Text("Prioritas: ${detailTodo?.priority}", style: TextStyle(fontSize: 20)),
              Text("Hari: ${detailTodo?.days}", style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
    );
  }

  void showConfirmDelete(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (alertContext){
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: Text("Apakah yakin untuk menghapus data ini?"),
          actions: [
            TextButton(
              onPressed: (){
              Navigator.pop(alertContext);
            }, child: Text("Batal")),
            TextButton(
              onPressed: (){
              Navigator.pop(alertContext);
              actionDelete();
              
            }, child: Text("Ya"))
          ],
        );
      }
    );
  }

  void actionDelete() async {
    try {
      await todoDatabase.deleteTodo(widget.id);
      Helper.showSnackbar(context, "Hapus data berhasil", bgColor: Colors.green);
      
      if(widget.isLandscape){
        widget.onDeleted?.call();
      } else {
        Navigator.pop(context, Helper.NEED_REFRESH);
      }

    } catch(e){
      Helper.showSnackbar(context, "Gagal, e: $e");
    }
  }


}