import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_pocket/blocs/blocs.dart';
import 'package:news_pocket/ui/screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NewsBloc()),
        BlocProvider(create: (_) => NewsSearchBloc()),
      ],
      child: MaterialApp(
        title: 'News Pocket',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade200,
        ),
        home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.grey.shade200,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: HomePage(),
        ),
      ),
    );
  }
}
