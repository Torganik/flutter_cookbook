import 'dart:ui';

import 'package:flutter/material.dart';

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
