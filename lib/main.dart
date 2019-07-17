// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:rediet_app/SignupLoginPage.dart';
import 'package:rediet_app/services/auth.dart';
// import 'package:rediet_app/newEmployee.dart';
// import 'package:rediet_app/viewEmployee.dart';
// import 'package:rediet_app/model/employee.dart';
// import 'package:rediet_app/services/firestoreservice.dart';
import 'package:rediet_app/services/mapping.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

    _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp>
{

// List<Employee> items;
// FireStoreService firServ = new FireStoreService();
// StreamSubscription<QuerySnapshot> toemployees;

//   @override
//   void initState()
//   {
//     super.initState();

//     items = new List();

//     toemployees?.cancel();
//     toemployees = firServ.getFileList().listen((QuerySnapshot snapshot)
//     {
//       final List<Employee> employees = snapshot.documents
//       .map((documentSnapshot) => Employee. fromMap(documentSnapshot.data)).toList();

//       setState(()
//       {
//           this.items = employees;
//       });
//     });

//   }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MappingPage(auth: Auth()),
      // home: ViewEmployeePage(),
      // home: NewEmployee(Employee(null, '', '', '', '')),
    );
  }
}
