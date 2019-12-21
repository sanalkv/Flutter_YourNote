import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import './notes.dart';

class Flare extends StatefulWidget {
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Flare> {
  @override
  Widget build(BuildContext context) {
    LinearGradient grad = new LinearGradient(
        colors: [Colors.yellow, Colors.orangeAccent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: grad),
        child: Column(children: <Widget>[
          Spacer(flex: 2,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 170,
                width: 120,
                child: FlareActor(
                  "assets/original.flr",
                  animation: "note",
                ),
              ),
              Text(
                "YourNote",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.orange,
                    fontFamily: "Pacifico"),
              ),
            ],
          ),
          Button(grad),
          Spacer()
        ]),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final LinearGradient grad;
  Button(this.grad);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 110),
      child: RaisedButton(
          splashColor: Colors.red,
          textColor: Colors.deepOrange,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Text(
            "Lets Note",
            style: TextStyle(
              fontFamily: "Times New Roman",
            ),
          ),
          color: Colors.orangeAccent,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Notes(grad: grad)));
          }),
    );
  }
}
