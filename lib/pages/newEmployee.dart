// import 'dart:developer';

import 'dart:core' as prefix0;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rediet_app/model/employee.dart';
import 'package:rediet_app/services/firestoreservice.dart';
import 'package:firebase_database/firebase_database.dart';

// add page
class NewEmployee extends StatefulWidget {
  final Employee emp;
  NewEmployee(this.emp);
  @override
  _NewEmployeeState createState() => _NewEmployeeState();
}

final empReference = FirebaseDatabase.instance.reference().child('employeeManager');


class _NewEmployeeState extends State<NewEmployee> {
  FireStoreService fireServ = new FireStoreService();

  TextEditingController _empFullnameController;
  TextEditingController _empAdressController;

  int _myGenderType = 0;
  String genderVal;
  void _handleGenderType(int value)
  {
    // log( value);
    setState(() {
     _myGenderType = value;
     switch(_myGenderType)
     {
       case 1:
       genderVal = 'Male';
       break;
       case 2:
       genderVal = 'Female';
       break;
     } 
    });
  }

  int _employeeType = 0;
  String empVal;
  void _handleEmployeeType(int value)
  {
    setState(() {
     _employeeType = value;
     switch(_employeeType)
     {
       case 1:
          empVal = 'Doctor';
          break;
       case 2:
          empVal = 'Engineer';
          break;
       case 3:
          empVal = 'IT Officer';
          break;
       case 4:
          empVal = 'Teacher';
          break;
       case 5:
          empVal = 'Others';
          break;
     } 
    });
  }
 
 
void initState() {
    super.initState();
    //text ctr checks if the textfields are empty
    _empFullnameController = new TextEditingController(text: widget.emp.fullname);
     _empAdressController = new TextEditingController(text: widget.emp.address);

  }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-90,
            decoration: BoxDecoration(
          gradient: LinearGradient(colors: [const Color(0xFFE9E4F0), const Color(0xFFFAFFD1)]),),
        
            child: ListView(
              
              children: createTextFields() + createRadioButtons() + createButtons(),
            ),
          )
        ],
      ),
    );
  }

  Widget logo()
    {
        return  Column(
              children: <Widget>[
                  Image.asset('assets/addEmp.png',
                              width: 300,
                              height: 100,),
                  Text('Edit Employee/s Information'),
                ],
              );  
    }


  List<Widget> createTextFields()
  {
    return
    [
      logo(),
       SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextFormField(
                    controller: _empFullnameController,
                    
                    decoration: InputDecoration(
                      labelText: "Full Name: ",
                      contentPadding: EdgeInsets.fromLTRB(25.0, 20.0, 10.0, 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(9.0))
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _empAdressController,
                    decoration: InputDecoration(
                      labelText: "Address: ",
                      contentPadding: EdgeInsets.fromLTRB(25.0, 20.0, 10.0, 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(9.0))
                      ),
                  ),
                ),
    ];
  }

  List<Widget> createRadioButtons()
  {
    return[
           SizedBox(height: 20,),

                 Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    'Gender:',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),

                 Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                 Radio(
                                    value: 1,
                                    groupValue: _myGenderType,
                                    onChanged: _handleGenderType,
                                    activeColor: Color(0xff0dc8f5),
                                  ),
                                  Text(
                                    'Male',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                              ],
                            ),
                           
                          ],
                        ),

                         Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: 2,
                                    groupValue: _myGenderType,
                                    onChanged: _handleGenderType,
                                    activeColor: Color(0xfffb537f),
                                  ),
                                  Text(
                                    'Female',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              )
                          ],
                        )
                        
                      ],
                    ),

                    
                   
                  ],
                ),

               SizedBox(height: 10,),

                 Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    'Select Task Type:',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),

                 Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                           groupValue: _employeeType,
                          onChanged: _handleEmployeeType,
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Doctor',
                          style: TextStyle(fontSize: 16.0),
                        ),

                        
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 2,
                           groupValue: _employeeType,
                          onChanged: _handleEmployeeType,
                          activeColor: Color(0xfffb537f),
                        ),
                        Text(
                          'Engineer',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 3,
                           groupValue: _employeeType,
                          onChanged: _handleEmployeeType,
                          activeColor: Color(0xff4caf50),
                        ),
                        Text(
                          'IT Officer',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 4,
                           groupValue: _employeeType,
                          onChanged: _handleEmployeeType,
                          activeColor: Color(0xff9962d0),
                        ),
                        Text(
                          'Teacher',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 5,
                          groupValue: _employeeType,
                          onChanged: _handleEmployeeType,
                          activeColor: Color(0xff0dc8f5),
                        ),
                        Text(
                          'Other',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
               
               
    ];
  }

 
  List<Widget> createButtons()
  {
    return[
      SizedBox(height: 3),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                        width: 110.0,
                        height: 50.0,
                        child:RaisedButton(
                        child: (widget.emp.id != null) ? Text('Update') : Text('Add'),
                        color: Color(0xFF1E9600),
                        textColor: Colors.white,
                        splashColor: Colors.cyanAccent,
                        onPressed: () {
                          if(widget.emp.id != null)
                          {
                               

                            print(_empFullnameController.text);
                           // print(_handleGenderType);
                            empReference.child(widget.emp.id).set({
                            'fullname': _empFullnameController.text,
                            'address': _empAdressController.text,
                            'gender':_handleGenderType,
                            'empType':_handleEmployeeType,
                          }).then((_) {
                            Navigator.pop(context);
                            });
                          }
                          else{
                            empReference.push().set({
                            'fullname': _empFullnameController.text,
                            'address': _empAdressController.text,
                            'gender':_handleGenderType,
                            'empType':_handleEmployeeType,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                        
                          }
                        }, 
                        shape: OutlineInputBorder(),
                        padding: EdgeInsets.all(16.0),
                        
                        
                        
                        ),),

                    SizedBox(
                        width: 110.0,
                        height: 50.0,
                        child: RaisedButton(
                        color: Color(0xFFFA7397),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        shape: OutlineInputBorder(),

                        padding: EdgeInsets.all(16.0),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Color(0xFFFDDE42)),
                        )),),
                    
                  ],
                )
    ];
  }

  Widget _myAppBar() {
    return Container(
      height: 90.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFF45a247),
              const Color(0xFF061700),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'Employee',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }


}
