import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/navigator/main_navigator.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final _sessionDataProvider = SessionDataProvider();
  final loginTextController = TextEditingController(text: 'fanat1ck');
  final resetPasswordController = TextEditingController(text: 'ivan2boda');
  String? _errorMassage;
  bool _isAuthProgress = false;

  String? get errorMassage => _errorMassage;
  bool get isAuthProgress => _isAuthProgress;
  bool get canStartAuth => !_isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = resetPasswordController.text;
    if (login.isEmpty || password.isEmpty) {
      _errorMassage = 'Заполните поля';
      notifyListeners();
      return;
    }
    _errorMassage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    int? accountId;

    try {
      sessionId = await _apiClient.auth(
        userName: login,
        password: password,
      );
      accountId = await _apiClient.getAccountInfo(sessionId);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.Network:
          _errorMassage =
              'Сервер не доступний. Перевірте підключення до інтернету';
          break;
        case ApiClientExceptionType.Auth:
          _errorMassage = 'Не правильний пароль';

          break;
        case ApiClientExceptionType.Other:
          _errorMassage = 'Сталася помилка. Попробуйте ще раз';
          break;
      }
    }
    _isAuthProgress = false;
    if (_errorMassage != null) {
      notifyListeners();
      return;
    }

    if (sessionId == null || accountId == null) {
      _errorMassage = 'Невідома помилка';

      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);

    unawaited(Navigator.of(context)
        .pushReplacementNamed(MainNavigatorRoutesName.mainScreen));
  }
}
