import 'package:flutter/material.dart';
import 'package:flutter_news_app/api/api_call.dart';

import 'package:url_launcher/url_launcher.dart';
import 'model/news_model.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final news = ApiCallClass().getNews();

  @override
  void initState() {
    print("Start building widget");
    super.initState();
  }

  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Article>>(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.data.toString());
        }
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data[index].urlToImage == null
                              ? ""
                              : snapshot.data[index].urlToImage),
                    ),
                    title: Text(snapshot.data[index].title == null
                        ? ""
                        : snapshot.data[index].title),
                    subtitle: Text(snapshot.data[index].author == null
                        ? ""
                        : snapshot.data[index].author),
                    trailing: IconButton(
                      icon: Icon(Icons.launch),
                      onPressed: () async {
                        await canLaunch(snapshot.data[index].url)
                            ? launch(snapshot.data[index].url)
                            : throw "Can't launch ${snapshot.data[index].url}";
                      },
                    ),
                  ));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      future: news,
    ));
  }
}
