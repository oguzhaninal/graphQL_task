import 'package:flutter/material.dart';
import 'package:graphql_demo/addPostDialog.dart';
import 'package:graphql_demo/widgets/myCard.dart';
import 'package:graphql_demo/pages/updatePost.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:connectivity/connectivity.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String netCon;
  int id;
  final String getAllPosts = """
  query getAllPosts{
  posts(options:{paginate: {page:1, limit:50}} ) {
    data {
      id
      title
      body
      user {
        username
      }
    }
    meta {
      totalCount
    }
  }
} """;

  String deletePost = """
  mutation deletePost(
  \$id: ID!
) {
  deletePost(id: \$id)
}
  
  """;
  checkConnect() async {
    final conResult = await Connectivity().checkConnectivity();
    print(" durum :" + conResult.toString());
    setState(() {
      netCon = conResult.toString();
    });
  }

  @override
  void initState() {
    super.initState();

    checkConnect();
  }

  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        onPressed: () {
          showGeneralDialog(
              context: context,
              transitionDuration: Duration(milliseconds: 320),
              pageBuilder: (
                context,
                a1,
                a2,
              ) {
                return Text("Update Post");
              },
              transitionBuilder: (context, a1, a2, widget) {
                return Transform.scale(scale: a1.value, child: AddPostDialog());
              });
        },
      ),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Query(
        options: QueryOptions(
          documentNode: gql(getAllPosts),
        ),
        builder: (
          QueryResult result, {
          fetchMore,
          refetch,
        }) {
          if (netCon == "ConnectivityResult.none") {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You must have an internet connection to continue"),
                  tryButton(context, phoneSize),
                ],
              ),
            );
          }
          if (result.hasException) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(result.exception.toString()),
                tryButton(context, phoneSize),
              ],
            ));
          }
          if (result.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List posts = result.data["posts"]["data"];
          return RefreshIndicator(
            onRefresh: refetch,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index]["title"];
                final postBody = posts[index]["body"];
                final id = posts[index]["id"];

                return ListTile(
                  title: MyPostCard(
                    phoneSize,
                    post,
                    postBody,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UpdateScreen(id, post, postBody),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  tryButton(BuildContext context, Size phoneSize) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: phoneSize.height * .05),
      child: Container(
        width: phoneSize.width * .3,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(15)),
        child: TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (Route<dynamic> route) => false);
          },
          child: Text(
            "Try Again",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
