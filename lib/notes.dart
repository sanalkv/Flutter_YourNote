import 'package:flutter/material.dart';
import "./noteadd.dart";
import 'dart:async';
import './models/note.dart';
import './package/database_helper.dart';
import 'dart:math';
import 'package:flare_flutter/flare_actor.dart';

Future<List<YourNote>> fetchNotes() async {
  var dbhelper = Dbhelper();
  Future<List<YourNote>> notes = dbhelper.getNotes();
  print(notes);
  return notes;
}

class Notes extends StatefulWidget {
  final LinearGradient grad;
  Notes({Key key, @required this.grad}) : super(key: key);
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List<Color> colour = [
    Colors.orange,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.deepOrange,
    Colors.pink
  ];
  Random rand = new Random();

  Color randomColor() {
    return colour[rand.nextInt(5)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.note_add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Addnote(widget.grad)));
        },
      ),
      body: Container(
        decoration: BoxDecoration(gradient: widget.grad),
        child: FutureBuilder<List<YourNote>>(
            future: fetchNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.isEmpty) {
                  return Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Text("ADD YOUR FIRST NOTE !!",
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: 22,
                                  color: Colors.orange)),
                        ),
                      ),
                      FlareActor("assets/flaree.flr", animation: "arrow")
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.yellow[500],
                            child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Addnote(
                                              widget.grad,
                                              snapshot.data[index])));
                                },
                                trailing: GestureDetector(
                                    onTap: () {
                                      delete(snapshot.data[index].title);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.orange[400],
                                    )),
                                title: Text(
                                  snapshot.data[index].title,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: 20,
                                      color: randomColor()),
                                )),
                          );
                        }),
                  );
                }
              } else {
                return Container(
                    alignment: AlignmentDirectional.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ));
              }
            }),
      ),
    );
  }

  void delete(title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Are you sure you want to delete ?",
              style: TextStyle(
                fontFamily: 'Times New Roman',
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  "Yes",
                  style: TextStyle(
                      fontFamily: 'Times New Roman', color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    Dbhelper db = new Dbhelper();
                    db.deleteNotes(title);
                  });

                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                  child: Text(
                    "No",
                    style: TextStyle(
                        fontFamily: 'Times New Roman', color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}
