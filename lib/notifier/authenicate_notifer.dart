import 'dart:async';
import 'dart:developer';

import 'package:demo1/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Map<String, String> requestHeaders = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
  "Authorization": "Bearer token",
};

final authenticateNotifier =
    AsyncNotifierProvider.autoDispose<AuthenticateState, AuthenticateModel>(
  AuthenticateState.new,
);

class AuthenticateState extends AutoDisposeAsyncNotifier<AuthenticateModel> {
  @override
  Future<AuthenticateModel> build() async {
    final authService = FirebaseAuth.instance;

    // final response = await get(Uri.https('boredapi.com', '/api/activity'));
    // final json = jsonDecode(response.body) as Map<String, dynamic>;
    // return AuthenticateModel.fromJson(json);
    final currentUser = authService.currentUser;
    if (currentUser != null) {
      final username = currentUser.displayName!.isEmpty ? "" : "";
      final email = currentUser.email!.isEmpty ? "" : "";
      final uid = currentUser.uid!.isEmpty ? "" : "";
      return AuthenticateModel(username: username, email: email, uuid: uid);
    }

    return AuthenticateModel(username: '', email: "", uuid: "");
  }

  void handleLogout() {
    state = AsyncData(AuthenticateModel(username: "", email: "", uuid: ""));
  }

  Future<void> handleSetUser(
      String? username, String? email, String? uuid) async {
    username ??= "";
    email ??= "";
    uuid ??= "";

    log(username);
    log(email);
    log(uuid);

    state = AsyncData(
        AuthenticateModel(username: username, email: email, uuid: uuid));
  }
}
