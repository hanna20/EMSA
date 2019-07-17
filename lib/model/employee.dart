// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

class Employee {
  String _empid;
  String _empFullname;
  String _empAdress;
  String _empgender;
  String _empType;

  Employee(this._empid,this._empFullname,this._empAdress, this._empgender, this._empType);

  Employee.map(dynamic obj)
  {
    this._empid = obj['id'];
    this._empFullname = obj['fullname'];
    this._empAdress = obj['address'];
    this._empgender = obj['gender'];
    this._empType = obj['empType'];
    
  }

  String get id => _empid;
  String get fullname => _empFullname;
  String get address => _empAdress;
  String get gender => _empgender;
  String get emptype => _empType;


  Map<String,dynamic> toMap()
  {
    var map=new Map<String,dynamic>();
    if (_empid != null) {
      map['id'] = _empid;
    }
    map['fullname'] = _empFullname;
    map['address'] = _empAdress;
    map['gender'] = _empgender;
    map['empType'] = _empType;


    return map;
  }

//_fromMap is just a simple wrapper to create a new 
// Employee list that we will use several times in our Future handlers.
  Employee.fromMap(Map<String,dynamic> map){
    this._empid = map['id'];
    this._empFullname = map['fullname'];
    this._empAdress = map['address'];
    this._empgender = map['gender'];
    this._empType = map['empType'];
  }
}