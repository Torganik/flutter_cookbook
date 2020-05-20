import 'dart:ui';

import 'package:flutter/material.dart';

class BackDropFilterTest extends StatefulWidget {
  final String title;
  BackDropFilterTest(this.title);

  @override
  _BackDropFilterTestState createState() => _BackDropFilterTestState();
}

class _BackDropFilterTestState extends State<BackDropFilterTest> {
  double sigmaX = 0;
  double sigmaY = 0;
  bool dotsIsOn = false;

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
      dotsIsOn = !dotsIsOn;
    });
  }

  Widget getPositionedFiler() {
    Widget result;
    if (dotsIsOn) {
      result = Positioned(
        top: 130, bottom: 160, left: 50,
        right: 120, // Positioned.fill Covers part of picture
        //TODO NOT WORKING! Why?!
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: this.sigmaX, sigmaY: this.sigmaY),
            child: Container(
              height: 10,
              width: 10,
              color: Colors.black.withOpacity(0),
              // color: Colors.black.withOpacity(0),
            )),
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
        title: Text(this.widget.title),
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
                          style: Theme.of(context).textTheme.headline6,
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
                          style: Theme.of(context).textTheme.headline6,
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
                        "Dots: " + (this.dotsIsOn ? "On" : "Off"),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
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
