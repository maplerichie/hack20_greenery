import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _username;
  TextEditingController _password;
  final _loginFormKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget _textField(TextEditingController ctrl, TextInputType type, Widget icon,
      String hint, int minLength, String errMsg,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: ctrl,
        keyboardType: type,
        validator: (value) {
          if (value.isEmpty && minLength != 0) {
            return "Please don't leave blank";
          }
          if (value.length < minLength) {
            return errMsg;
          }
          return null;
        },
        obscureText: isPassword,
        autofocus: false,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Container(
            child: icon,
            margin: EdgeInsets.only(
              left: 32.0,
              right: 32.0,
            ),
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Color(0x44000000),
          ),
          contentPadding:
              EdgeInsets.only(left: 30, bottom: 18, top: 18, right: 30),
          fillColor: Color(0x11000000),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _resetPwBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        child: Text(
          'Reset Password?',
        ),
        onTap: () {
          print('Reset pw');
        },
      ),
    );
  }

  Widget _loginBtn() {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 16),
      color: Colors.green,
      child: Text(
        'Login',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      onPressed: () async {
        // if (_loginFormKey.currentState.validate()) {
        // if (!await Provider.of<AuthProvider>(context, listen: false).login(
        //   username: _username.text.trim(),
        //   password: _password.text.trim(),
        // )) {
        //   _key.currentState.showSnackBar(SnackBar(
        //     content: Text("Invalid credential. Please try again."),
        //   ));
        // }
        // }

        if (!await Provider.of<AuthProvider>(context, listen: false)
            .loginAnonymous(true)) {
          _key.currentState.showSnackBar(SnackBar(
            content: Text("Invalid credential. Please try again."),
          ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                "assets/images/bliss.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: deviceSize.height * 0.1,
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    width: deviceSize.width / 2,
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.025,
                  ),
                  Provider.of<AuthProvider>(context).status ==
                          Status.Authenticating
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Form(
                          key: _loginFormKey,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              _textField(
                                  _username,
                                  TextInputType.emailAddress,
                                  Icon(
                                    Mdi.account,
                                    size: 24.0,
                                  ),
                                  "Username",
                                  6,
                                  "Invalid username"),
                              _textField(
                                _password,
                                TextInputType.visiblePassword,
                                Icon(
                                  Mdi.lock,
                                  size: 24.0,
                                ),
                                "Password",
                                6,
                                "Invalid password",
                                isPassword: true,
                              ),
                              _resetPwBtn(),
                              SizedBox(
                                height: deviceSize.height * 0.025,
                              ),
                              _loginBtn(),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
