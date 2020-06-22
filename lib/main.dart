import 'package:auto_route/auto_route.dart';
import 'package:fakensplash/bloc/collection/collection_bloc.dart';
import 'package:fakensplash/bloc/photo/photo_bloc.dart';
import 'package:fakensplash/route/splash_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiredash/wiredash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
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
      child: Wiredash(
        projectId: 'fakensplash-k2gyhjm',
        secret: 'pszdeapx8xfs08u7833odbwi4fd21who',
        options: WiredashOptionsData(
          showDebugFloatingEntryPoint: false,
        ),
        navigatorKey: _navigatorKey,
        child: MaterialApp(
          // navigatorKey: _navigatorKey,
          title: 'FakenSplash',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.black,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // home: MainPage(),
          builder: (context, child) => ExtendedNavigator(
            key: _navigatorKey,
            router: SplashRouter(),
          ),
        ),
      ),
    );
  }
}
