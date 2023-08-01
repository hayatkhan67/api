import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

import 'model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

Future <News>fetchData()async{
  const uri='https://newsapi.org/v2/everything?q=tesla&from=2023-07-01&sortBy=publishedAt&apiKey=07cfd066147947b9bdd50568599efddb';
  final response=await http.get(Uri.parse(uri));
  log("Status Code ${response.statusCode}");
  log("Response body ${response.body}");
  if(response.statusCode==200){
    log('sucess');
    Map<String,dynamic>json=jsonDecode(response.body);
    return News.fromJson(json);
  }
  return News();
}


  @override
  Widget build(BuildContext context) {
    fetchData();
    return  Scaffold(
      appBar: AppBar(
        title:const Text('Api test'),
      centerTitle: true,
    backgroundColor: Colors.indigoAccent,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder( 
          future: fetchData(),
          builder: (context, snapshot) {
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
         return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            const Center(child: Text('Single Value')),
             Card(
              color: Colors.amber,
               child: ListTile(
                title: Text("status:${snapshot.data!.status.toString()}"),
               subtitle: Text("total:${snapshot.data!.totalResults.toString()}"),
               ),
             ),
            const Center(child: Text('Single key List')),
      
             ...List.generate(snapshot.data!.articles!.length, (index) => 
             Card(
              color: Colors.amber,
               child: ListTile(
                title: Text("author:$index ${snapshot.data!.articles![index].author.toString()}"),
                subtitle: Text("title:$index ${snapshot.data!.articles![index].title.toString()}"),
               ),
             ),),
            // const Center(child: Text('Single key Map')),
      
            //  Card(
            //   color: Colors.amber,
            //    child: ListTile(
            //     title: Text("learning:${snapshot.data!.detailMap!.learning.toString()}"),
            //    subtitle: Row(
            //      children: [
            //        Text("Supportor:${snapshot.data!.detailMap!.alkhidmat.toString()}:\t"),
            //        Text("Rank:${snapshot.data!.detailMap!.rank.toString()}"),
            //      ],
            //    ),
            //    ),
            //  ),
      
            // const Center(child: Text('List of Maps')),
            // ...List.generate(snapshot.data!.detailListOfMap!.length, (index) => 
            //  Card(
            //   color: Colors.amber,
            //    child: ListTile(
            //     title: Text("Name: ${snapshot.data!.detailListOfMap![index].student.toString()}"),
            //     subtitle: Text("id: ${snapshot.data!.detailListOfMap![index].id.toString()}"),
            //    ),
            //  ),),
      
            
           ],
         );
          }
            
          }
          ),
      ),
    );
  }
}