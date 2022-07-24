import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widget/Inherited/provider.dart';
import 'package:themoviedb/Theme/app_button_style.dart';
import 'package:themoviedb/widgets/auth/auth_model.dart';

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

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ErrorMassageWidget(),
        const Text('Username', style: AppButtonStyle.textStyle),
        const SizedBox(height: 5),
        TextField(
            controller: model?.loginTextController,
            decoration: AppButtonStyle.textFieldDecoration),
        const SizedBox(height: 25),
        const Text(
          'Password',
          style: AppButtonStyle.textStyle,
        ),
        const SizedBox(height: 5),
        TextField(
          controller: model?.resetPasswordController,
          decoration: AppButtonStyle.textFieldDecoration,
          obscureText: true,
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            const _AuthButtonWidget(),
            const SizedBox(width: 30),
            TextButton(
              style: AppButtonStyle.linkButton,
              onPressed: () {},
              child: const Text('Reset password'),
            )
          ],
        )
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthModel>(context);

    final onPressed =
        model?.canStartAuth == true ? () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true
        ? const SizedBox(
            height: 15, width: 20, child: CircularProgressIndicator())
        : const Text('Login');
    return ElevatedButton(
      style: AppButtonStyle.loginButton,
      onPressed: onPressed,
      child: child,
    );
  }
}

class _ErrorMassageWidget extends StatelessWidget {
  const _ErrorMassageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMassage =
        NotifierProvider.watch<AuthModel>(context)?.errorMassage;
    if (errorMassage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMassage,
        style: const TextStyle(color: Colors.red, fontSize: 17),
      ),
    );
  }
}
