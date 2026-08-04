import 'package:flutter/material.dart';
import 'package:receipt_app/components/item_meal_widget.dart';
import 'package:receipt_app/models/meals_response.dart';
import 'package:receipt_app/services/remote_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int selectedIndex = 0;

  late List<Widget> body = [seafoodView(), favoriteView()];

  late Future<List<Meals>?> seafoodList;

  @override
  void initState() {
    super.initState();
    seafoodList = getSeafoodList();
  }

  Future<List<Meals>?> getSeafoodList() async {
    return await RemoteService().fetchMealsByCategory("Seafood");
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe App"),),
      body: body[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: "Seafood"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
        ]
      ),
    );
  }



  Widget seafoodView(){
    return Center(
      child: FutureBuilder(
        future: seafoodList,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else if(snapshot.hasError){
            return Column(
              children: [
                Text(snapshot.error.toString()),
                FilledButton(onPressed: (){}, child: Text("refresh"))
              ],
            );
          }

          final list = snapshot.data ?? [];

          return listData(list);
        }
      ),
    );
  }


  Widget listData(List<Meals> listMeal){
    return ListView.builder(
      itemCount: listMeal.length,
      itemBuilder: (context, index) {
        return ItemMealWidgets(meal: listMeal[index]);
      }
    );
  }

  Widget favoriteView(){
    return Center(child: Text("Favorite view"));
  }
}