import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/screens/auth/login_screen.dart';
import 'package:firebase_chat/utils/helper.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final collection = "chat-agustus2026";
  late TextEditingController textFieldMessageController;

  @override
  void initState() {
    super.initState();
    textFieldMessageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          IconButton(
            onPressed: actionLogout,
            icon: Icon(Icons.exit_to_app)
          )
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
              listChat(),
              textFieldMessage()
          ],
        )
      ),
    );
  }


  Widget listChat(){
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(collection).orderBy('time', descending: false).snapshots(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }

          return snapshot.data?.size == 0
            ? Center(child: Text("Belum ada percakapan"))
            : ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data?.docs[index];
                final message = data?["message"];
                final sender = data?["sender"];

                final isSender = sender == FirebaseAuth.instance.currentUser?.email;

                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(sender),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if(isSender)...{
                            IconButton(onPressed: (){ showAlertEdit(data?.id ?? "", message); }, icon: Icon(Icons.edit)),
                            IconButton(onPressed: (){ actionDelete(data?.id ?? ""); }, icon: Icon(Icons.delete))
                          },
                          Flexible(
                            child: Material(
                              elevation: 6,
                              borderRadius: BorderRadius.only(
                                topRight: isSender ? Radius.zero : Radius.circular(24),
                                topLeft: isSender ? Radius.circular(24) : Radius.zero,
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24)
                              ),
                              color: isSender ? Colors.blue : Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(message, style: TextStyle(
                                  color: isSender ? Colors.white : Colors.black
                                ),),
                              ),
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                );
              
              }
            );
        }
      )
    );
  }

  Widget textFieldMessage(){
    return TextField(
      controller: textFieldMessageController,
      textInputAction: TextInputAction.send,
      onSubmitted: (value){
        sendMessage();
      },
      decoration: InputDecoration(
        hintText: "Ketik pesan",
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        suffixIcon: IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.send)
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(16)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(16)
        ),
      ),
    );
  }


  void actionLogout() async{
    try {
      await FirebaseAuth.instance.signOut();

      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false
      );
    } catch(exc) {
      Helper.showSnackBar(context, "Error logout $exc");
    }
  }

  void sendMessage() async {
    if(textFieldMessageController.text.trim().isEmpty){
      Helper.showSnackBar(context, "Error, field harus adaan cuy");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection(collection).add({
        "message": textFieldMessageController.text.trim(),
        "sender": FirebaseAuth.instance.currentUser?.email,
        "time": DateTime.now()
      });

      textFieldMessageController.text = '';
    } catch(exc) {
      Helper.showSnackBar(context, "Error $exc");
    }
  }

  void actionDelete(String id) async {
    try {
      await FirebaseFirestore.instance.collection(collection).doc(id).delete();
    } catch (exc) {
      Helper.showSnackBar(context, "Error $exc");
    }
  }

  void showAlertEdit(String id, String message) {
    showDialog(
      context: context,
      builder: (alertContext) {
        final editController = TextEditingController(text: message);

        return AlertDialog(
          title: Text("Edit Pesan"),
          content: TextField(
            controller: editController,
            autofocus: true,
            maxLines: null,
            decoration: InputDecoration(
              hintText: "Ketik pesan"
            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                if(editController.text.trim().isNotEmpty){
                  actionEdit(id, editController.text.trim());
                  Navigator.pop(alertContext);
                }
              },
              child: Text("Simpan")
            )
          ],
        );
      }
    );
  }

  void actionEdit(String id, String message) async {
    try {
      await FirebaseFirestore.instance.collection(collection).doc(id).update({
        "message": message
      });
    } catch (exc) {
      Helper.showSnackBar(context, "Error $exc");
    }
  }

}