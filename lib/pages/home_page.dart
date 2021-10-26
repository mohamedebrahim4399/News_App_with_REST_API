import 'package:flutter/material.dart';
import 'package:news_app_with_rest_api/models/news_model.dart';
import 'package:news_app_with_rest_api/services/api_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<NewsModel>? _newsModel;
  @override
  void initState() {
    _newsModel = ApiManager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: FutureBuilder<NewsModel>(
        future: _newsModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.articles!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 150,

                      child: Row(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            clipBehavior: Clip.antiAlias,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                  snapshot.data!.articles![index].urlToImage!,fit: BoxFit.cover ,),
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Flexible(
                            child: Column(
                              children: [
                                Text(snapshot.data!.articles![index].title!,overflow: TextOverflow.ellipsis,maxLines: 2,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                const SizedBox(height: 5,),
                                Text(snapshot.data!.articles![index].description!,overflow: TextOverflow.ellipsis,maxLines: 4,style: const TextStyle(fontSize: 14,),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
