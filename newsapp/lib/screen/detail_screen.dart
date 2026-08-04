import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/model/news_response.dart';
import 'package:newsapp/screen/webview_screen.dart';
import 'package:newsapp/utils/helper.dart';

class DetailScreen extends StatelessWidget {

  final Articles articles;
  const DetailScreen({super.key, required this.articles});



  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height;

    String? content = articles.content;
    int? dotStart = content?.indexOf("…");
    String? contentModified;
    if(dotStart != null && content != null){
     contentModified = content.substring(0, dotStart);

    }


    return Scaffold(
      body: Column(
        children: [
      
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: screenHeight / 3,
                child: Image.network(
                  fit: BoxFit.cover,
                  articles.urlToImage ?? "",
                  errorBuilder: (context, error, stackrace){
                    return Icon(Icons.image_not_supported);
                  },
                  loadingBuilder: (context, child, progress){
                    if(progress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),

              
              Padding(
                padding:  EdgeInsets.only(top: statusBarHeight, left: 16),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)
                  ),
                ),
              )
            ],
          ),

          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  articles.title ?? "no title",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),

                Text(
                  "${articles.source?.name} - ${Helper.formatDate(articles.publishedAt ?? "", "dd MMMM yyyy")}"
                ),

                RichText(
                  text: TextSpan(
                    text: contentModified ?? "no content",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    children: [
                      
                      TextSpan(
                        text: "...Klik disini untuk lengkapnya.",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic
                        ),
                        recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WebviewScreen(url: articles.url ?? "https://google.com"))
                          );
                        }
                      )
                    ]
                  ),
                )

                // Text(
                //   articles.content ?? "no content",
                //   style: TextStyle(
                //     fontSize: 18
                //   )

                // ),
                
                // GestureDetector(
                //   onTap: (){
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => WebviewScreen(url: articles.url?? "https://google.com"))
                //     );
                //   },
                //   child: Text(
                //     "Baca selengkapnya disini",
                //     style: TextStyle(
                //       color: Colors.blue,
                //       fontSize: 18,
                //       fontStyle: FontStyle.italic,
                //       decoration: TextDecoration.underline,
                //       decorationColor: Colors.blue,
                //     ),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }

  
}

extension Replacer on String{
  String replaceAt(int index, String replacement){
    return "${this.substring(0, index)}$replacement${this.substring(index + replacement.length)}";
  }
}
