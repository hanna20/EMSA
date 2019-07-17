import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rediet_app/services/firestoreservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'newEmployee.dart';
import 'package:rediet_app/model/employee.dart';
import 'package:rediet_app/services/auth.dart';

class ViewEmployeePage extends StatefulWidget {
  ViewEmployeePage({
    this.auth,
    this.onSignedOut,
  });

  final AuthImplementation auth;
  final VoidCallback onSignedOut;
  @override
  _ViewEmployeePageState createState() => _ViewEmployeePageState();
}

class _ViewEmployeePageState extends State<ViewEmployeePage> {
  List<Employee> employees;
  FireStoreService fireServ = new FireStoreService();
  StreamSubscription<QuerySnapshot> collemp;

  void _logoutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }

  void _navigateToEmp(BuildContext context, Employee emp) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewEmployee(emp)),
    );
  }

  @override
  void initState() {
    super.initState();

    employees = new List();

    collemp?.cancel();
    collemp = fireServ.getFileList().listen((QuerySnapshot snapshot) {
      final List<Employee> emps = snapshot.documents
          .map((documentSnapshot) => Employee.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.employees = emps;
      });
    });
  }

  @override
  void dispose() {
    collemp.cancel();
    super.dispose();
  }

  void _deleteEmp(BuildContext context, Employee empo, int index) async {
    fireServ.deleteEmp(empo.id).then((fi) {
      setState(() {
        employees.removeAt(index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(context),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  return Stack(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80.0,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Material(
                            color: Colors.white,
                            elevation: 14.0,
                            shadowColor: Color(0x802196F3),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    exType('${employees[index].emptype}'),
                                    Text(
                                      '${employees[index].fullname}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20.0),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${employees[index].address}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${employees[index].gender}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(FontAwesomeIcons.edit),
                                          color: Colors.blue,
                                          onPressed: () => _navigateToEmp(context, employees[index]),
                                         
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(FontAwesomeIcons.trash),
                                          color: Colors.redAccent,
                                          onPressed: () => _deleteEmp(
                                              context, employees[index], index),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]);
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          FontAwesomeIcons.plus,
          color: Color(0xFFFDDE42),
        ),
        onPressed: () {
           Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NewEmployee(Employee(null, '', '', '', '')),
                fullscreenDialog: true),
          );
        },
      ),
    );
  }

  Widget exType(String icontype) {
    IconData iconval;
    Color colorval;
    switch (icontype) {
      case 'Doctor':
        iconval = FontAwesomeIcons.userMd;
        // iconval =;
        colorval = Color(0xffFF0000);
        break;
      case 'Engineer':
        iconval = FontAwesomeIcons.hardHat;
        colorval = Color(0xff4286f4);
        break;
      case 'IT Officer':
        iconval = FontAwesomeIcons.userShield;
        colorval = Color(0xff4caf50);
        break;
      case 'Teacher':
        iconval = FontAwesomeIcons.chalkboardTeacher;
        colorval = Color(0xff9962d0);
        break;
      default:
        iconval = FontAwesomeIcons.user;
        colorval = Color(0xff0dc8f5);
      //
    }
    return CircleAvatar(
      backgroundColor: colorval,
      child: Icon(iconval, color: Colors.white, size: 20.0),
    );
  }

  Widget _myAppBar(context) {
    return Container(
      height: 80.0,
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
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: Container(
                  child: Text(
                    'All Employees',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.signOutAlt,
                    color: Colors.white,
                  ),
                  onPressed: _logoutUser,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
