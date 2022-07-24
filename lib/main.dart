import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/myApp/my_app_modal.dart';
import 'Library/Widget/Inherited/provider.dart';
import 'widgets/myApp/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MyAppModel();
  await model.checkAuth();
  const app = MyApp();
  final widget = Provider(model: model, child: app);

  runApp(widget);
}
