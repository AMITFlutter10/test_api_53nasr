import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_api_53nasr/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  String url = "https://reqres.in/api/users";
//  http
//  Future<void> getData()async {
//    http.Response response = await http.get(Uri.parse(url)).
//    then((value) { print("response : ${value.body}   status ${value.statusCode}");
//    return value;
//    });
//   }
//http
//   Future<UserModel> getData() async {
//     try {
//       http.Response response = await http.get(Uri.parse(url));
//       print("response : ${response.body}   status ${response.statusCode}");
//       return UserModel.fromJson(jsonDecode(response.body));
//     } catch (error) {
//       print(error);
//       throw ();
//     }
//   }


  // dio

 Dio dio = Dio();
 Future<UserModel> getData()async{
   try{
      var response=  await  dio.get(url);
      print("package dio  response : ${response.data} statusCode:"
          "  ${response.statusCode}");
    return UserModel.fromJson(response.data);
   } catch(error){
     print(error);
     throw();
   }
  }





  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<UserModel>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError) {
                    return Text("error is happend");
                  } else {
                    return Column(
                      children: [
                        ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final model = snapshot.data!.data![index];
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                child: Image.network("${model.avatar}"),
                              ),
                              title: Text("${model.firstName}"),
                              subtitle: Text("${model.email}"),
                              trailing: Text("${model.id}"),
                            );
                          },
                          itemCount: snapshot.data!.data!.length,
                        ),
                      ],
                    );
                  }
              }
            }));
  }
}
