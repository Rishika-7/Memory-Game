import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorygame/data/data.dart';

import 'model/tile_model.dart';

void main() {
  runApp(MemoryGame());
}

class MemoryGame extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TileModel> gridViewTiles = new List<TileModel>();
  List<TileModel> questionPairs = new List<TileModel>();

  bool letsPlay = false;
  int noOfQuestion = 0;

  @override
  void initState() {
    super.initState();
  }

  void reStart() {
    myPairs = getPairs(gameLevel);
    myPairs.shuffle();

    gridViewTiles = myPairs;

    if (gameLevel == "easy") {
      noOfQuestion = 6;
    } else if (gameLevel == "medium") {
      noOfQuestion = 8;
    } else if (gameLevel == "hard") {
      noOfQuestion = 12;
    }

    Future.delayed(const Duration(seconds: 7), () {
      setState(() {
        questionPairs = getQuestionPairs(gameLevel);
        gridViewTiles = questionPairs;
        selected = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Memory Game',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.amber),
      body: letsPlay
          ? SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    points != noOfQuestion
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "$points/$noOfQuestion",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Points",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    points != noOfQuestion
                        ? GridView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    mainAxisSpacing: 0.0,
                                    maxCrossAxisExtent: 120),
                            children:
                                List.generate(gridViewTiles.length, (index) {
                              return Tile(
                                imageAssetPath:
                                    gridViewTiles[index].getImageAssetPath(),
                                parent: this,
                                tileIndex: index,
                              );
                            }),
                          )
                        : Center(
                            child: GestureDetector(
                              onTap: () {
                                letsPlay = false;
                                reStart();
                                setState(() {
                                  points = 0;
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    " 🎉",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 150),
                                  ),
                                  SizedBox(
                                    height: 80,
                                  ),
                                  Container(
                                    height: 60,
                                    width: 170,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      border: Border.all(
                                          width: 3, color: Colors.black),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: Text(
                                      "REPLAY",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Images/jungle4.png"),
                  fit: BoxFit.fill,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      gameLevel = "easy";
                      setState(() {
                        letsPlay = true;
                      });
                      reStart();
                    },
                    child: Container(
                      height: 60,
                      width: 170,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Text(
                        "EASY",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      gameLevel = "medium";
                      setState(() {
                        letsPlay = true;
                      });
                      reStart();
                    },
                    child: Container(
                      height: 60,
                      width: 170,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Text(
                        "MEDIUM",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      gameLevel = "hard";
                      setState(() {
                        letsPlay = true;
                      });
                      reStart();
                    },
                    child: Container(
                      height: 60,
                      width: 170,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Text(
                        "HARD",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class Tile extends StatefulWidget {
  final String imageAssetPath;
  final int tileIndex;
  final _HomePageState parent;

  Tile({this.imageAssetPath, this.tileIndex, this.parent});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!selected) {
          setState(() {
            myPairs[widget.tileIndex].setIsSelected(true);
          });
          if (selectedTile != "") {
            if (selectedTile == myPairs[widget.tileIndex].getImageAssetPath()) {
              points = points + 1;
              TileModel tileModel = new TileModel();
              selected = true;
              Future.delayed(const Duration(seconds: 1), () {
                tileModel.setImageAssetPath("");
                myPairs[widget.tileIndex].setImageAssetPath("");
                myPairs[selectedIndex] = tileModel;
                this.widget.parent.setState(() {});
                setState(() {
                  selected = false;
                });
                selectedTile = "";
              });
            } else {
              selected = true;
              Future.delayed(const Duration(seconds: 2), () {
                this.widget.parent.setState(() {
                  myPairs[widget.tileIndex].setIsSelected(false);
                  myPairs[selectedIndex].setIsSelected(false);
                });
                setState(() {
                  selected = false;
                });
              });

              selectedTile = "";
            }
          } else {
            setState(() {
              selectedTile = myPairs[widget.tileIndex].getImageAssetPath();
              selectedIndex = widget.tileIndex;
            });
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: myPairs[widget.tileIndex].getImageAssetPath() != ""
            ? Image.asset(myPairs[widget.tileIndex].getIsSelected()
                ? myPairs[widget.tileIndex].getImageAssetPath()
                : widget.imageAssetPath)
            : Container(
                child: Image.asset("assets/correct.png"),
              ),
      ),
    );
  }
}
