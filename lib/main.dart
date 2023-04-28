import 'dart:convert';

import 'package:ampcom/homepage.dart';
import 'package:ampcom/selectedGenreProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectedGenres>(
      create: (context) => SelectedGenres(),
      child: MaterialApp(
        title: 'MyApp',
        home: SignUpScreen(),
      ),
    );
  }
}
