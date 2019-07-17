import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rediet_app/model/employee.dart';

//name of the collection in firestore
//A CollectionReference object can be used for adding documents, 
//getting document references, and querying for documents 
//(using the methods inherited from Query).
final CollectionReference collReference = Firestore.instance.collection('employeeManager');

class FireStoreService
{
  /* A [Future] is used to represent a potential value, or error, 
  that will be available at some time in the future. Receivers 
  of a [Future] can register callbacks that handle the value or 
  error once it is available*/
  Future<Employee> createEmployee(String empFullname, String empAddress, String empGender, String empType) async
  {
    final TransactionHandler createTransaction = (Transaction tx) async
    {
      /* when it is marked as async, anything returned from that function
       is immediately wrapped in a Future unless it is already one.*/
      
      /*A DocumentSnapshot contains data read from a document in 
        your Firestore database. */
      /*document() Returns a DocumentReference with the provided path. */
      final DocumentSnapshot ds = await tx.get(collReference.document());
      final Employee emp = Employee(ds.documentID,empFullname, empAddress, empGender,empType);
      final Map<String, dynamic> data = emp.toMap();
      /*Await pauses the running code to for the Future to 
      resolve before it moves on to the next line.*/
      await tx.set(ds.reference, data);
      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData)
    {
      return Employee.fromMap(mapData);
    }).catchError((onError){
        print('error:$onError');
        return null;
    });
 }


  //stream builder is a widget that will take a stram of data and essentially observe it for changes. that way when the stream updates, the UI will update 
    Stream<QuerySnapshot> getFileList({int offset, int limit})
    {
      Stream<QuerySnapshot> snapshot = collReference.snapshots(); 
      if(offset != null)
      {
          snapshot = snapshot.skip(offset);
      } 
      if (limit != null)
      {
          snapshot = snapshot.skip(limit);
      }
      return snapshot;
   
  }

   Future<dynamic> updateEmployee(Employee emp) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(collReference.document(emp.id));
 
      await tx.update(ds.reference, emp.toMap());
        return {'updated': true};
    
    };
 
    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

   Future<dynamic> deleteEmp(String id) async{
   final TransactionHandler deleteTransaction = (Transaction tx) async{
     final DocumentSnapshot ds = await tx.get(collReference.document(id));
      await tx.delete(ds.reference);
      return {'deleted': true};
   };

   return Firestore.instance.runTransaction(deleteTransaction).then((result) => result['deleted'])
    .catchError((error){
      print('error: $error');
      return false;
    });
 }

 
}