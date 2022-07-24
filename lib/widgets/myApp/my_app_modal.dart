import 'package:flutter/cupertino.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/navigator/main_navigator.dart';

class MyAppModel {
  var _isAuth = false;
  final _sessionDataprovider = SessionDataProvider();
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataprovider.getsessionId();
    _isAuth = sessionId != null;
  }

  Future<void> resetSesion(BuildContext context) async {
    await _sessionDataprovider.setSessionId(null);
    await _sessionDataprovider.setAccountId(null);
    await Navigator.pushNamedAndRemoveUntil(
        context, MainNavigatorRoutesName.auth, (route) => false);
  }
}
