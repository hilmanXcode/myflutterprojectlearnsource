import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newsapp/model/news_response.dart';
import 'package:newsapp/screen/detail_screen.dart';
import 'package:newsapp/utils/helper.dart';

class NewsScreen extends StatefulWidget {

  final String category;

  const NewsScreen({super.key, required this.category});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  late Future<List<Articles>?> futureListArticle;

  @override
  void initState() {
    super.initState();
    
    futureListArticle = getNews();
  }

  Future <List<Articles>?> getNews() async {

    final baseUrl = "https://newsapi.org/v2/";
    final endpoint = "top-headlines";
    final category = widget.category;
    final apiKey = "c6d5aeee6c014b88adf17ef8e484ab7c";
    final url = "$baseUrl$endpoint?category=$category&apiKey=$apiKey";

    try {

      // 2 params, uri & headers
      final response = await http.get(Uri.parse(url));
      final json = NewsResponse.fromJson(jsonDecode(response.body));

      if(response.statusCode == 200){
        return json.articles;
      } else {
        throw json.message ?? "Error";
      }

    } catch(e){
      throw e.toString();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: futureListArticle,
          builder: (context, snapshot){

            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snapshot.hasError){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.error.toString()),
                    FilledButton(onPressed: (){
                      setState(() {
                        futureListArticle = getNews();
                      });
                    }, child: Text("Refresh"))
                  ],
                ) 
              );
            }
            else if(snapshot.hasData){
              final listArticle = snapshot.data;
              if(listArticle == null || listArticle.isEmpty){
                return Center(
                  child: Text("Tidak ada data"),
                );
              } else {
                return ListView.builder(
                  itemCount: listArticle.length,
                  itemBuilder: (context, index){
                    final article = listArticle[index];
                    return cardNews(article);
                  }
                );
              }
            }
            return SizedBox();
          }
        )
      );
  }

  Widget cardNews(Articles article){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(articles: article) 
          )
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
          
          ),
          elevation: 4,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16)
                  ),
                  child: SizedBox(
                    width: 128,
                    height: 128,
                    child: Image.network(
                      fit: BoxFit.cover,
                      article.urlToImage ?? "",
                      errorBuilder: (context, error, stackrace){
                        return Icon(Icons.image_not_supported);
                      },
                      loadingBuilder: (context, child, progress){
                        if(progress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
            
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 16,
                      children: [
                        Text(
                          article.title ?? "no title",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
            
                        Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                article.source?.name ?? "no source"
                              ),
                            ),
                            Text(
                              Helper.formatDate(article.publishedAt ?? "no published date", "dd MMMM yyyy")
                            ) 
                          ],
                        )
                      ],
                    )
                  ),
                ),
                
            
              ],
            ),
          ),
      ),
    );
  }

}