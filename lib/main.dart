import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/DI/service_locator.dart';
import 'package:spotify_clone/bloc/authentication/authentication_bloc.dart';
import 'package:spotify_clone/bloc/favorite/favorite_playlist_cubit.dart';
import 'package:spotify_clone/bloc/search/search_bloc.dart';
import 'package:spotify_clone/firebase_options.dart';
import 'package:spotify_clone/ui/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  };
  initServiceLocator();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthenticationBloc()),
    BlocProvider(create: (context) => SearchBloc()),
    BlocProvider(create: (context) => FavoritePlaylistCubit()),

  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
