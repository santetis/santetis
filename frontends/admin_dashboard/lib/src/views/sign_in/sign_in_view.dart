import 'package:admin_dashboard/src/state/app.dart';
import 'package:flutter/material.dart';
import 'package:network_entities/network_entities.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool submitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 48,
            ),
            Text(
              'Connexion',
              style: TextStyle(
                fontSize: 36,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Form(
                child: Center(
                  child: SizedBox(
                    width: 600,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Adresse mail',
                            labelText: 'Adresse mail',
                            alignLabelWithHint: true,
                            contentPadding: EdgeInsets.only(
                              left: 30,
                              top: 0,
                              right: 0,
                              bottom: 0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            suffixIcon: Icon(Icons.mail),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Mot de passe',
                              labelText: 'Mot de passe',
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.only(
                                left: 30,
                                top: 0,
                                right: 0,
                                bottom: 0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              suffixIcon: Icon(Icons.vpn_key),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Row(
                            children: <Widget>[
                              Spacer(),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                color: Theme.of(context).primaryColor,
                                disabledColor: Color.lerp(
                                  Theme.of(context).primaryColor,
                                  Colors.white,
                                  0.2,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Connexion'.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: submitting
                                    ? null
                                    : () async {
                                        setState(() {
                                          submitting = true;
                                        });
                                        final appState = Provider.of<AppState>(
                                          context,
                                          listen: false,
                                        );
                                        try {
                                          await appState
                                              .signIn(SignInRequestData(
                                            emailController.text,
                                            passwordController.text,
                                          ));
                                          unawaited(Navigator.of(context)
                                              .pushReplacementNamed(
                                                  'dashboard'));
                                        } catch (e) {
                                          print(e);
                                          await Future.delayed(
                                              Duration(seconds: 10));
                                          setState(() {
                                            submitting = false;
                                          });
                                        }
                                      },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
