import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/model/user_model.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel? _user;

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
        on<LogoutRequested>(_onLogoutRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      _user = UserModel.fromFirebaseUser(userCredential.user!);
      log("User: ${_user!.toMap()}");
      emit(AuthenticationSuccess());
    } catch (e) {
      log(e.toString());
      emit(AuthenticationFailure(e.toString()));
    }
  }

  void _onRegisterRequested(RegisterRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      _user = UserModel.fromFirebaseUser(userCredential.user!, username: event.username);
      await _firestore.collection('users').doc(_user!.uid).set(_user!.toMap());
      emit(AuthenticationSuccess());
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }
  void _onLogoutRequested(LogoutRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      await _auth.signOut();
      _user = null;
      emit(AuthenticationInitial());
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }
  UserModel? get user => _user;
}