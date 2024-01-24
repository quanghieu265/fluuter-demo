import 'package:demo1/models/user_model.dart';
import 'package:demo1/notifier/authenicate_notifer.dart';
import 'package:demo1/pages/cart_page.dart';
import 'package:demo1/pages/home_page.dart';
import 'package:demo1/pages/login_page.dart';
import 'package:demo1/provider/counter.dart';
import 'package:demo1/services/auth_service.dart';
import 'package:demo1/widgets/app_bar_widget.dart';
import 'package:demo1/widgets/bottom_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitPage extends ConsumerStatefulWidget {
  const InitPage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<InitPage> {
  final List<Widget> _routes = [
    HomePage(),
    const CartPage(),
    LoginPage(),
  ];

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(authenticateNotifier);
    final routeIndex = ref.watch(routerProvider);

    void handleBottomNav(index) {
      ref.read(routerProvider.notifier).state = index;
    }

    return Scaffold(
      bottomNavigationBar: BottomNavBar(
          onHandleChangeTab: (index) => handleBottomNav(index),
          routeIndex: routeIndex),
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50), // here the desired height
          child: AppBarFnc()),
      drawer: Builder(builder: (context) {
        return Drawer(
            child: Column(
          children: [
            DrawerHeader(
                child: userData.when(
              data: (data) {
                return Container(
                  alignment: Alignment.center, // <-- ALIGNMENT
                  height: 10,
                  child: Text(data.email.isEmpty
                      ? "Anonymous"
                      : "Hello, ${data.username.isEmpty ? data.email : data.username}"),
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () => Container(
                alignment: Alignment.center, // <-- ALIGNMENT
                height: 10,
                child: const CircularProgressIndicator(),
              ),
            )),
            TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)))),
              onPressed: () =>
                  {handleBottomNav(0), Scaffold.of(context).closeDrawer()},
              child: const ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)))),
              onPressed: () =>
                  {handleBottomNav(1), Scaffold.of(context).closeDrawer()},
              child: const ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text("Cart"),
              ),
            ),
            switch (userData) {
              // If some data is available, we display it.
              // Note that data will still be available during a refresh.
              AsyncValue<AuthenticateModel>(:final valueOrNull?) => TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)))),
                  onPressed: () => {
                    if (valueOrNull.email.isEmpty)
                      {
                        ref.read(routerProvider.notifier).state = 2,
                        Scaffold.of(context).closeDrawer()
                      }
                    else
                      {
                        _auth.handleSignOut(),
                        ref.read(routerProvider.notifier).state = 2,
                        Scaffold.of(context).closeDrawer()
                      }
                  },
                  child: ListTile(
                    leading: Icon(
                        valueOrNull.email.isEmpty ? Icons.login : Icons.logout),
                    title:
                        Text(valueOrNull.email.isEmpty ? "Log In" : "Log Out"),
                  ),
                ),
              // An error is available, so we render it.
              AsyncValue(:final error?) => Text('Error: $error'),
              // No data/error, so we're in loading state.
              _ => const CircularProgressIndicator()
            }
          ],
        ));
      }),
      body: _routes[routeIndex],
    );
  }
}
