import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';




class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _formKey = GlobalKey<FormState>();

  Future<void> _signout() async{
    try{
      await FirebaseAuth.instance.signOut();
    }catch(e)
    {
      print(e);
    }
  }

  final List<dynamic> weight =[];
  TextEditingController weightController = TextEditingController();
  //final  dbref = FirebaseDatabase(databaseURL: "https://weight-tracker-3fd62-default-rtdb.firebaseio.com").reference();
  final dbref = FirebaseDatabase.instance.reference().child("Weights");
  //final dbref = FirebaseDatabase.instance.reference();

  late int count;

  void weightCount(){
    setState(() {
      count++;
    });
  }


  void addItemToList(){
    setState(() {
     weight.insert(0,weightController.text);
    });
  }

  void sendData(){
    // dbref.child("1").set({
    //
    //   'Weight':weightController.text
    //
    // });

    dbref.push().set({
      "Weight":weightController.text
    });
  }

  void deleteData(){
    dbref.child('1').remove();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Weight Tracking App'),
        actions: [
          FlatButton(onPressed: _signout, child: Text('Logout',style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),))
        ],

      ),
      body: Column(
        children: [
          TextField(
            controller:weightController ,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Weight'
            ),
          ),
          RaisedButton(
            child: Text('Add'),
            onPressed: (){
              addItemToList();
              sendData();
             //  if(_formKey.currentState!.validate()) {
             //
             //    dbref.push().set({
             //      "Weight":weightController.text,
             //    }).then((_){
             //      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sucessfully Added'),));
             //      weightController.clear();
             //    }).catchError((onError){
             //
             //      ScaffoldMessenger.of(context)
             //          .showSnackBar(SnackBar(content: Text(onError)));
             //
             //    });

              // }


              },
          ),
          SizedBox(height: 10,),
          RaisedButton(
              onPressed:() {
            deleteData();

          },
            child:Text('Delet data from Database'),),
          Expanded(child: ListView.builder(
            itemCount: weight.length,
            itemBuilder: (context,index){

              final weights = weight[index];

              return Dismissible(
                  key: Key(weights),
                  onDismissed: (direction){
                    setState(() {
                      weight.removeAt(index);
                      deleteData();
                    });
                    
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('deleted successfully'),));

                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(2),
                    color: Colors.grey,
                    child: Center(
                      child: Text('${weight[index]}',
                        style: TextStyle(fontSize: 18),),
                    ),
                  ),
              );

            },
          ))
        ],
      ),
    );
  }
}
