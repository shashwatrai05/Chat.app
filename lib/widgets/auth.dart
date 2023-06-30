import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn,this.isLoading);
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _islogin = true;
  var _userEmail = '';
  var _username = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      _formKey.currentState!.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _username.trim(),
          _islogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: const ValueKey('Email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@kiet.edu')) {
                        return 'Please Enter a valid KIET ID';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if (!_islogin)
                    TextFormField(
                      key: const ValueKey('Username'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _username = value!;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('Password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return 'Password must contain atleast 8 Characters';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if(widget.isLoading) CircularProgressIndicator(),
                  if(!widget.isLoading)
                  ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_islogin ? 'Login' : 'SignUp')),
                      if(!widget.isLoading)
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _islogin = !_islogin;
                        });
                      },
                      child: Text(_islogin
                          ? 'Create New Account'
                          : 'Already have an account'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
