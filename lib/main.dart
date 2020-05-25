import 'package:flutter/material.dart';
import 'package:flutter_cookbook/widgets_for_demo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage("Select what you want to test"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final List<WidgetContainer> widgetsList = List();
  MyHomePage(this.title);
  @override
  Widget build(BuildContext context) {
    this.widgetsList.add(WidgetContainer(nameAndTitle:BackDropFilterTest.widgetName,content: BackDropFilterTest()));
    this.widgetsList.add(WidgetContainer(nameAndTitle:AlignTest.widgetName,content: AlignTest()));
    this.widgetsList.add(WidgetContainer(nameAndTitle:PostionedTest.widgetName,content: PostionedTest()));
    this.widgetsList.add(WidgetContainer(nameAndTitle:AnimatedBuilderDemo.widgetName,content: AnimatedBuilderDemo()));
    this.widgetsList.add(WidgetContainer(nameAndTitle:DismissibleDemo.widgetName,content: DismissibleDemo()));
    this.widgetsList.add(WidgetContainer(nameAndTitle:SizedBoxDemo.widgetName,content: SizedBoxDemo()));
    
    


    return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        backgroundColor: Colors.grey.shade300,
        body: ListView.builder(itemCount: this.widgetsList.length, itemBuilder: (BuildContext ctx, int index) {
          WidgetContainer content = this.widgetsList[index]; 

          return Container(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorLight,
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>content.content),
            );
            },
            child: Text(content.nameAndTitle),
          )));
        }));
  }
}

class WidgetContainer {
  String nameAndTitle;
  Widget content;
  WidgetContainer({String nameAndTitle,Widget content}) {
    this.content = content;
    this.nameAndTitle = nameAndTitle;
  } 
}
