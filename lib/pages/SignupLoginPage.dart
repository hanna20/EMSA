import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:rediet_app/services/auth.dart';

class SignupLoginPage extends StatefulWidget {
  SignupLoginPage({this.auth, this.onSignedIn});

  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() {
    return _SignupLoginState();
  }
}

enum FormType { login, signup }

class _SignupLoginState extends State<SignupLoginPage> {
  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth.signIn(_email, _password);
          print("Login userId = " + userId);
        } else {
          String userId = await widget.auth.signup(_email, _password);
          print("Register userId = " + userId);
        }

        widget.onSignedIn();
      } catch (e) {
        print("Error = " + e.toString());
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.signup;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xFF4e4376), const Color(0xFF2b5876)]),
        ),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: ListView(
              children: createInputs() + createButtons(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 60.0,
      ),
      logo(),
      SizedBox(
        height: 20.0,
      ),
      TextFormField(
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 17.0, color: Colors.white),
        decoration: new InputDecoration(
          hintText: 'Email Adress',
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        validator: (value) {
          return value.isEmpty ? 'Email is required' : null;
        },
        onSaved: (value) {
          return _email = value;
        },
      ),
      SizedBox(height: 10.0),
      TextFormField(
        obscureText: true,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 17.0, color: Colors.white),
        decoration: new InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        validator: (value) {
          return value.isEmpty ? 'Password is required' : null;
        },
        onSaved: (value) {
          return _password = value;
        },
      ),
      SizedBox(height: 20.0),
    ];
  }

  Widget logo() {
    return Hero(
      tag: 'hero',
      child: new CircleAvatar(
        // backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('assets/lock.png'),
      ),
    );
  }

  List<Widget> createButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.white,
          color: Colors.blue,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text("Don't have an Account? Signup Here",
              style: TextStyle(fontSize: 16.0)),
          textColor: Colors.grey,
          onPressed: moveToRegister,
        ),
        SizedBox(height: 20.0),
      ];
    } else {
      return [
        RaisedButton(
          child: Text(
            "Signup",
            style: TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.white,
          color: Colors.lightGreen,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text("Already have an Account? Login",
              style: TextStyle(fontSize: 16.0)),
          textColor: Colors.grey,
          onPressed: moveToLogin,
        ),
        SizedBox(height: 20.0),
      ];
    }
  }
}
