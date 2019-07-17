import 'package:flutter/material.dart';
import 'package:rediet_app/pages/SignupLoginPage.dart';
import 'package:rediet_app/pages/viewEmployee.dart';
import 'auth.dart';

class MappingPage extends StatefulWidget
{
    final AuthImplementation auth;

    MappingPage({this.auth});

    State<StatefulWidget> createState()
    {
      return _MappingPageState();
    }
}

enum AuthStatus{
  notSignedIn,
  signedIn
}

class _MappingPageState extends State<MappingPage>
{
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState()
  {
    super.initState();

    widget.auth.getCurrentUser().then((firebaseUserId)
    {
      setState(() {
        authStatus = firebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn; 
      });
    });
  }

  void _signedIn()
  {
    setState(() {
     authStatus = AuthStatus.signedIn; 
    });
  }

  void _signedOut()
  {
    setState(() {
     authStatus = AuthStatus.notSignedIn; 
    });
  }

  @override
  Widget build(BuildContext context)
  {
    switch (authStatus) 
    {
      case AuthStatus.notSignedIn:
      return new SignupLoginPage
      (
        auth: widget.auth,
        onSignedIn: _signedIn,
      );    

      case AuthStatus.signedIn:
      return new ViewEmployeePage
      (
        auth: widget.auth,
        onSignedOut: _signedOut
      ); 
       
    }
    // return new SignupLoginPage(auth: widget.auth);
    return null;
  }

}