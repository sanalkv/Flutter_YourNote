import 'package:flutter/material.dart';
import './models/note.dart';
import './package/database_helper.dart';

class Addnote extends StatefulWidget {
  final LinearGradient grad;
  final YourNote  note;
  
 
  Addnote(this.grad,[this.note]);
  
  @override
  AddnoteState createState() {
        return new AddnoteState(grad,this.note);
  }
}

class AddnoteState extends State<Addnote> {
   final mycontroller = TextEditingController();
   final mycontroller1 = TextEditingController();
    YourNote note;
  

  final LinearGradient grad;
  AddnoteState(this.grad,[this.note]);
  int count = 0;

  @override
  void dispose() {
    mycontroller.dispose();
    mycontroller1.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
      if(note!=null){
    mycontroller.text=note.title;
    mycontroller1.text=note.content;
      }
    
    
   
    return Scaffold(
        appBar: null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.save,color: Colors.white,),
          onPressed: () {
            if(note!=null){
              var title=note.title;
              note.title=mycontroller.text;
              note.content=mycontroller1.text;
              
              var dbhelper = Dbhelper();
              dbhelper.updateNotes(title,mycontroller.text,mycontroller1.text);
              Navigator.pop(context);
            }
            else{
            if (!(mycontroller.text.isEmpty ||
                mycontroller1.text.isEmpty ||
                mycontroller.text == " " ||
                mycontroller1.text == " ")) {
              var yournote = YourNote(mycontroller.text, mycontroller1.text);
              var dbhelper = Dbhelper();
              dbhelper.saveNotes(yournote);
              print("data saved successfully");
              Navigator.pop(context);
            } else {
              return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: widget.grad),
                            child: Center(
                                child: Text(
                              "Forgot to fill it up ? ",
                              style: TextStyle(
                                  color: Colors.orange[900],
                                  fontFamily: "Times New Roman",
                                  fontSize: 20),
                            ))));
                  });
            }}
          },
        ),
        body: (Container(
          decoration: BoxDecoration(gradient: widget.grad),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10, right: 10, bottom: 80),
            child: ListView(
              children: <Widget>[
                Container(
                    child: Center(
                        child: Text(
                  "YourNote",
                  
                  
                  style: TextStyle(
                      color: Colors.orange,
                      fontFamily:'Pacifico',
                      fontSize: 30),
                ))),
                TextField(
                  cursorColor: Colors.orange,
                  textCapitalization: TextCapitalization.sentences,
                  controller: mycontroller,
                  decoration: InputDecoration(labelText: "Title", ),
                 
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: TextField(
                     textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.orange,
                    controller: mycontroller1,
                    
                    decoration:
                        InputDecoration(labelText: "Your content goes here"),
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
