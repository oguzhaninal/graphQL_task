import 'package:flutter/material.dart';
import 'package:graphql_demo/config.dart';
import 'package:graphql_demo/pages/homePage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final HttpLink apiLink = HttpLink(
      //   headers: {
      //   "content-type": "application/json",
      //   "x-hasura-admin-secret":
      //       "W86075Rs5lVfwyrQgyFdlvZ9M5Y2H6T8N3jDReXl2rJPHP8REEuTM7XQOiF6TU36",
      // },
      uri: "https://graphqlzero.almansi.me/api");

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client =
        ValueNotifier<GraphQLClient>(GraphQLClient(
      cache: InMemoryCache(),
      link: apiLink,
    ));
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        theme: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: MainColors.mainOrange),
            appBarTheme: AppBarTheme(
              color: MainColors.mainOrange,
            )),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
