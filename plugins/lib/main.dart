import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'post_model.dart';

Future<List<Post>> fetchPost() async {

  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if(response.statusCode == 200){
    List jsonResponse = jsonDecode(response.body);

    return jsonResponse.map((post) => Post.fromJson(post)).toList();
  }
  else{
    throw Exception('Failed to load posts');
  }
}

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  @override
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Fetch Data Example',
      home: const PostList(), 
      
    );
  }

}


class PostList extends StatefulWidget{
  const PostList({super.key});

  _PostListState createState() => _PostListState();

}

class _PostListState extends State<PostList>{ 

  late Future<List<Post>> futurePosts;

  @override
  void initState(){
    super.initState();
    futurePosts = fetchPost();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Data'),
      ),

      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
          return Center(child: Text('Error: ${snapshot..error}'));
          }
          else if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].body),
                );
              },
            );

          }else{
            return const Center(child: Text('No data available'));
          }
        } 
      )
      );

  }
}





