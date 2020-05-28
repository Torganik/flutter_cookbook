import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 25: BackDropFilter
class BackDropFilterTest extends StatefulWidget {
  static get widgetName => "25: BackDropFilter";
  @override
  _BackDropFilterTestState createState() => _BackDropFilterTestState();
}

class _BackDropFilterTestState extends State<BackDropFilterTest> {
  double sigmaX = 0;
  double sigmaY = 0;
  bool ovalIsOn = false;

  addSigmaX() {
    if (sigmaX == 10) {
      return;
    }
    setState(() {
      sigmaX += 1;
    });
  }

  subSigmaX() {
    if (sigmaX == 0) {
      return;
    }
    setState(() {
      sigmaX -= 1;
    });
  }

  addSigmaY() {
    if (sigmaY == 10) {
      return;
    }
    setState(() {
      sigmaY += 1;
    });
  }

  subSigmaY() {
    if (sigmaY == 0) {
      return;
    }
    setState(() {
      sigmaY -= 1;
    });
  }

  toggleDottsMode() {
    setState(() {
      ovalIsOn = !ovalIsOn;
    });
  }

  Widget getPositionedFiler() {
    Widget result;
    if (ovalIsOn) {
      result = Positioned(
        top: 130, bottom: 160, left: 50,
        right: 120, // Positioned.fill Covers part of picture
        child: ClipOval(
          //  Need to Clip, else Container with filter fill all stack
          child: Container(
            height: 50,
            width: 50,
            child: BackdropFilter(
                filter:
                    ImageFilter.blur(sigmaX: this.sigmaX, sigmaY: this.sigmaY),
                child: Container(
                  color: Colors.black.withOpacity(0),
                  // color: Colors.black.withOpacity(0),
                )),
          ),
        ),
      );
    } else {
      // Picture is 352 x 343
      result = Positioned.fill(
        // Positioned.fill Covers All widgets
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: this.sigmaX, sigmaY: this.sigmaY),
            child: Container(
              color: Colors.black.withOpacity(0),
            )),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BackDropFilterTest.widgetName),
      ),
      body: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(border: Border.all()),
              margin: EdgeInsets.all(5),
              alignment: Alignment.center,
              child: Image.network(
                  "https://i.pinimg.com/originals/a2/20/8e/a2208ec2139b07cc4bbac87c28e6bc98.png"),
            ),
            this.getPositionedFiler(),
          ]),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                            child: Text(
                          "Sigma X: " + this.sigmaX.toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        )),
                        RaisedButton(
                          onPressed: this.addSigmaX,
                          child: Text("Add"),
                        ),
                        RaisedButton(
                          onPressed: this.subSigmaX,
                          child: Text("Sub"),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                            child: Text(
                          "Sigma Y: " + this.sigmaY.toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        )),
                        RaisedButton(
                          onPressed: this.addSigmaY,
                          child: Text("Add"),
                        ),
                        RaisedButton(
                          onPressed: this.subSigmaY,
                          child: Text("Sub"),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Oval: " + (this.ovalIsOn ? "On" : "Off"),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      RaisedButton(
                        onPressed: this.toggleDottsMode,
                        child: Text("Toggle"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// 26: Align
class AlignTest extends StatefulWidget {
  static get widgetName => "26: Align";
  @override
  _AlignTestState createState() => _AlignTestState();
}

class _AlignTestState extends State<AlignTest> {
  final List<Widget> alignExamples = List();
  @override
  void initState() {
    super.initState();
    alignExamples.add(_ACE("Top Right", Alignment.topRight));
    alignExamples.add(_ACE("Top Left", Alignment.topLeft));
    alignExamples.add(_ACE("Top Center", Alignment.topCenter));
    alignExamples.add(_ACE("Bottom Center", Alignment.bottomLeft));
    alignExamples.add(_ACE("Bottom Center", Alignment.bottomCenter));
    alignExamples.add(_ACE("Bottom Right", Alignment.bottomRight));
    alignExamples.add(_ACE("Center", Alignment.center));
    alignExamples.add(_ACE("Center Left", Alignment.centerLeft));
    alignExamples.add(_ACE("Center Right", Alignment.centerRight));
    alignExamples.add(_ACE("Alignment(0.5, 0.2)", Alignment(0.5, 0.2)));
    alignExamples.add(_ACE("Alignment(1.0, 1.0)", Alignment(1, 1)));
    alignExamples.add(_ACE("Alignment(-1.0, 1.0)", Alignment(-1, 1)));
    alignExamples.add(_ACE("Alignment(-1.0, 0.5)", Alignment(-1, 0.5)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AlignTest.widgetName),
      ),
      body: ListView.builder(
          itemCount: this.alignExamples.length,
          itemBuilder: (BuildContext context, int index) {
            return this.alignExamples[index];
          }),
    );
  }
}

// Align Container Example for ListElement
class _ACE extends StatelessWidget {
  final String title;
  final Alignment alignment;
  _ACE(this.title, this.alignment);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all()),
      margin: EdgeInsets.all(2),
      height: 120,
      child: Align(alignment: this.alignment, child: Text(this.title)),
    );
  }
}

// 27: Positioned
class PostionedTest extends StatefulWidget {
  static String get widgetName => "27: Positioned";
  @override
  __PostionedTestState createState() => __PostionedTestState();
}

class __PostionedTestState extends State<PostionedTest> {
  final List<Widget> positionedItems = List();
  @override
  void initState() {
    super.initState();
    positionedItems.add(_PITE(0, 0));
    positionedItems.add(_PITE(15, 20));
    positionedItems.add(_PITE(29, -6));
    positionedItems.add(_PITE(78, 35));
    positionedItems.add(_PITE(99, 37));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(PostionedTest.widgetName),
        ),
        body: ListView.builder(
          itemCount: positionedItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              height: 100,
              child: this.positionedItems[index],
            );
          },
        ));
  }
}

// Positioned item test element
class _PITE extends StatelessWidget {
  final double left;
  final double top;

  _PITE(this.left, this.top);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: this.top,
          left: this.left,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.cyanAccent,
            ),
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.amber,
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Text("Cyan position is top: ${this.top} left: ${this.left}"),
        )
      ],
    );
  }
}

// 28: AnimatedBuilder
class AnimatedBuilderDemo extends StatefulWidget {
  static String get widgetName => "28: AnimatedBuilder";
  @override
  _AnimatedBuilderDemoState createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  bool isTweenSpinning = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onTweenPictureTap() {
    setState(() {
      isTweenSpinning = !isTweenSpinning;
    });

    if (isTweenSpinning) {
      controller.repeat();
    } else {
      controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final animation = Tween(begin: 0, end: 2 * pi).animate(controller);

    return Scaffold(
      appBar: AppBar(
        title: Text(AnimatedBuilderDemo.widgetName),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: this.onTweenPictureTap,
            child: AnimatedBuilder(
              animation: animation,
              child: Image.network(
                  "https://i.pinimg.com/originals/a2/20/8e/a2208ec2139b07cc4bbac87c28e6bc98.png"),
              builder: (context, child) {
                return Transform.rotate(
                  angle: animation.value.toDouble(),
                  child: child,
                );
              },
            ),
          ),
          Text(
            (isTweenSpinning
                ? "Hey, Look! I`am spinning, spinning!"
                : "Tap for spin"),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          )
        ],
      ),
    );
  }
}

// 29: Dismissible
class DismissibleDemo extends StatefulWidget {
  static String get widgetName => "29: Dismissible";
  @override
  _DismissibleDemoState createState() => _DismissibleDemoState();
}

class _DismissibleDemoState extends State<DismissibleDemo> {
  List<String> listElements = [
    "list element 1",
    "list element 2",
    "list element 3",
    "list element 4",
    "list element 5",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(DismissibleDemo.widgetName),
            bottom: TabBar(tabs: [
              Tab(
                child: Text("Vertical list"),
              ),
              Tab(
                child: Text("Horrizontal list"),
              ),
            ]),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                  itemCount: listElements.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Dismissible(
                        onDismissed: (direction) {
                          setState(() {
                            listElements.removeAt(index);
                          });
                        },
                        key: ValueKey(listElements[index]),
                        secondaryBackground: Container(
                          child: Text(
                            "Delete?",
                            textScaleFactor: 2,
                            textAlign: TextAlign.right,
                          ),
                          color: Colors.amber,
                        ),
                        background: Container(
                          child: Text(
                            "Accept?",
                            textScaleFactor: 2,
                          ),
                          color: Colors.cyan,
                        ),
                        child: ListTile(
                            title: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(listElements[index]))),
                      ),
                    );
                  }),
              Center(
                child: Container(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listElements.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Container(
                            height: 120,
                            child: Dismissible(
                              direction: DismissDirection.up,
                              onDismissed: (direction) {
                                setState(() {
                                  listElements.removeAt(index);
                                });
                              },
                              background: Container(
                                color: Colors.amber,
                              ),
                              key: ValueKey(listElements[index]),
                              child: Container(
                                height: 50,
                                width: 100,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.deepPurpleAccent
                                        .withOpacity(0.2)),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text("el_$index")),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          )),
    );
  }
}

// 30: SizedBox
class SizedBoxDemo extends StatefulWidget {
  static String get widgetName => "30: SizedBox";
  @override
  _SizedBoxDemoState createState() => _SizedBoxDemoState();
}

class _SizedBoxDemoState extends State<SizedBoxDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(SizedBoxDemo.widgetName)),
      body: Column(children: [
        SizedBox(
          height: 50,
          width: 70,
          child: Container(child: Text("Sized box 50x70"), color: Colors.green),
        ),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: Container(
            color: Colors.amber,
            child: Text("Container 200xinfinity"),
          ),
        ),
        SizedBox(
          height: 76,
          width: 75,
          child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Text("Text 76x75 ")),
        ),
        MaterialButton(
          onPressed: () {
            print("Hello");
          },
          elevation: 5.0,
          color: Colors.amberAccent,
          child: Text("Press me"),
        ),
        SizedBox(
          height: 200,
          width: 150,
          child: MaterialButton(
            onPressed: () {
              print("Hello");
            },
            elevation: 5.0,
            color: Colors.amberAccent,
            child: Text("Same button sized on 200x150"),
          ),
        )
      ]),
    );
  }
}

//31: ValueListenableBuilder
class ValueListenableBuilderDemo extends StatelessWidget {
  // With ValueListenableBuilder i can rebuild StatelessWidget
  static String get widgetName => "31: ValueListenableBuilder";
  final ValueNotifier<int> valNotify = ValueNotifier(1);

  // My data notifier
  final ButtonPressNotifier buttonNotifier =
      ButtonPressNotifier(ButtonPressData());

  // Methods that changes data.
  void onPressPlus() {
    valNotify.value = valNotify.value + 1;
    buttonNotifier.pressButton(true);
  }

  void onPressMinus() {
    buttonNotifier.pressButton(false);
    if (valNotify.value == 0) {
      return;
    }
    valNotify.value = valNotify.value - 1;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List();

    widgets.add(Container(
      alignment: Alignment.center,
      child: ValueListenableBuilder(
        valueListenable: valNotify,
        builder: (BuildContext context, int val, _) {
          return Text("Value is: $val");
        },
      ),
    ));

    widgets.add(Row(
      children: [
        Expanded(
            child: RaisedButton(
                onPressed: onPressPlus,
                child: ValueListenableBuilder(
                  valueListenable: buttonNotifier,
                  builder: (BuildContext context, ButtonPressData val, _) {
                    return Text("Add pressed ${val.addPress} times");
                  },
                ))),
        Expanded(
            child: RaisedButton(
          onPressed: onPressMinus,
          child: ValueListenableBuilder(
            valueListenable: buttonNotifier,
            builder: (BuildContext context, ButtonPressData val, _) {
              return Text("Sub pressed ${val.subPress} times");
            },
          ),
        )),
      ],
    ));

    widgets.add(Row(
      children: [
        Expanded(
            flex: 1,
            child: ValueListenableBuilder(
              valueListenable: valNotify,
              builder: (BuildContext context, int val, _) {
                return Text("$val");
              },
            )),
        Expanded(
            flex: 2,
            child: Text(
              "Data widget №1",
              textAlign: TextAlign.right,
            )),
      ],
    ));

    widgets.add(Row(
      children: [
        Expanded(flex: 2, child: Text("Data widget №2 is:")),
        Expanded(
            flex: 1,
            child: ValueListenableBuilder(
              valueListenable: valNotify,
              builder: (BuildContext context, int val, _) {
                return Text("$val");
              },
            )),
      ],
    ));

    widgets.add(Row(
      children: [
        Expanded(flex: 2, child: Text("Data widget 3 (mult. by 3):")),
        Expanded(
            flex: 1,
            child: ValueListenableBuilder(
              valueListenable: valNotify,
              builder: (BuildContext context, int val, _) {
                return Text("${val * 3}");
              },
            )),
      ],
    ));

    return Scaffold(
        appBar: AppBar(
            title: ValueListenableBuilder(
                valueListenable: valNotify,
                builder: (BuildContext context, int val, _) {
                  return Text(ValueListenableBuilderDemo.widgetName + "($val)");
                })),
        body: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (BuildContext cntx, int index) {
            return Container(
                height: 50,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all()),
                child: widgets[index]);
          },
        ));
  }
}

// Custom notifier for data class ButtonPressData
class ButtonPressNotifier extends ValueNotifier<ButtonPressData> {
  ButtonPressNotifier(ButtonPressData value) : super(value);

  void pressButton(bool add) {
    if (add) {
      this.value.pressAdd();
    } else {
      this.value.pressSub();
    }
    this.notifyListeners();
  }
}

// Data class for custom notifier demo
class ButtonPressData {
  int addPress = 0;
  int subPress = 0;

  void pressAdd() {
    addPress += 1;
  }

  void pressSub() {
    subPress += 1;
  }
}
