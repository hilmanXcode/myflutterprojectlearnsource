import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:newsapp/screen/news_screen.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  late TabController tabController;
  late List<String> categories;
  late List<Tab> tabs;


  @override
  void initState() {
    super.initState();
    
    categories = ["business", "entertainment", "general", "technology", "health", "science", "sports"];
    tabs = categories.map((category) => Tab(text: category.toUpperCase())).toList();
    tabController = TabController(
      length: categories.length,
      vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Center(
          child: Text("News App"),
        ),
        bottom: TabBar(
          tabs: tabs,
          controller: tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: categories.map((category){
          return NewsScreen(category: category);
        }).toList(),
      ),
      
    );
  }
}
