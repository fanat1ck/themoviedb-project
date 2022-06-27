import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_button_style.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your account'),
        centerTitle: true,
      ),
      body: ListView(
        children: const [_HeaderWidget()],
      ),
    );
  }
}

class _HeaderWidget extends StatefulWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  State<_HeaderWidget> createState() => __HeaderWidgetState();
}

class __HeaderWidgetState extends State<_HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          const _FormWidget(),
          const SizedBox(height: 25),
          const Text(
              'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple.',
              style: AppButtonStyle.textStyle),
          const SizedBox(height: 5),
          TextButton(
              style: AppButtonStyle.linkButton,
              onPressed: () {},
              child: const Text('Register')),
          const SizedBox(height: 25),
          const Text(
              'If you signed up but didn\'t get your verification email.',
              style: AppButtonStyle.textStyle),
          const SizedBox(height: 5),
          TextButton(
              style: AppButtonStyle.linkButton,
              onPressed: () {},
              child: const Text('Verifi email'))
        ],
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  State<_FormWidget> createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {
  final _loginTextController = TextEditingController(text: 'admin');
  final _resetPasswordController = TextEditingController(text: 'admin');

  String? _textError = null;
  void _auth() {
    final login = _loginTextController.text;
    final password = _resetPasswordController.text;
    if (login == 'admin' && password == 'admin') {
      _textError = null;
      Navigator.pushReplacementNamed(context, '/main_screen');
    } else {
      _textError = 'Не правильний пароль';
      print('show error');
    }
    setState(() {});
  }

  void _resetPassword() {
    print('Reset Password');
  }

  @override
  Widget build(BuildContext context) {
    final textError = _textError;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (textError != null) ...[
          Text(
            textError,
            style: const TextStyle(color: Colors.red, fontSize: 17),
          ),
          const SizedBox(height: 20)
        ],
        const Text('Username', style: AppButtonStyle.textStyle),
        const SizedBox(height: 5),
        TextField(
            controller: _loginTextController,
            decoration: AppButtonStyle.textFieldDecoration),
        const SizedBox(height: 25),
        const Text(
          'Password',
          style: AppButtonStyle.textStyle,
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _resetPasswordController,
          decoration: AppButtonStyle.textFieldDecoration,
          obscureText: true,
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppButtonStyle.color),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8))),
              onPressed: _auth,
              child: const Text('Login'),
            ),
            const SizedBox(width: 30),
            TextButton(
              style: AppButtonStyle.linkButton,
              onPressed: _resetPassword,
              child: const Text('Reset password'),
            )
          ],
        )
      ],
    );
  }
}
