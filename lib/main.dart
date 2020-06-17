import 'package:auto_route/auto_route.dart';
import 'package:fakensplash/bloc/collection/collection_bloc.dart';
import 'package:fakensplash/bloc/photo/photo_bloc.dart';
import 'package:fakensplash/route/splash_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color(0xfff5f6fa),
      systemNavigationBarColor: Color(0xfff5f6fa),
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PhotoBloc(),
        ),
        BlocProvider(
          create: (_) => CollectionBloc(),
        )
      ],
      child: MaterialApp(
        title: 'FakenSplash',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: (context, child) => ExtendedNavigator(
          router: SplashRouter(),
        ),
      ),
    );
  }
}
