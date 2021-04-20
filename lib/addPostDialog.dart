import 'package:flutter/material.dart';
import 'package:graphql_demo/widgets/myAlertDialog.dart';
import 'package:graphql_demo/widgets/myTextField.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'pages/homePage.dart';

class AddPostDialog extends StatefulWidget {
  @override
  _AddPostDialogState createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool valueBody = false;
  bool valueTitle = false;
  String addPost = """
  mutation (
  \$input: CreatePostInput!
) {
  createPost(input: \$input) {
    id
    title
    body
  }
}
  
  
  """;
  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;
    return Mutation(
        options: MutationOptions(
            documentNode: gql(addPost),
            onCompleted: (dynamic resultUpdateData) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return MyAlertDialog(
                        "Post Updated", resultUpdateData.toString());
                  });
            }),
        builder: (RunMutation runMutationAdd, QueryResult resultAdd) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Add Post"),
                IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (Route<dynamic> route) => false);
                    })
              ],
            ),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MyTextField(titleController, "Title", phoneSize, valueTitle),
                  MyTextField(
                      bodyController, "What's going on", phoneSize, valueBody),
                  InkWell(
                    onTap: () {
                      setState(() {
                        titleController.text.isEmpty
                            ? valueTitle = true
                            : valueTitle = false;
                        bodyController.text.isEmpty
                            ? valueBody = true
                            : valueBody = false;
                      });
                      if (valueBody == false) {
                        if (valueTitle == false) {
                          runMutationAdd({
                            "input": {
                              "title": titleController.text,
                              "body": bodyController.text,
                            }
                          });
                          showDialog(
                            context: context,
                            // ignore: missing_return
                            builder: (context) {
                              return MyAlertDialog(
                                "Post Updated",
                                resultAdd.data.toString(),
                              );
                            },
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                      ),
                      child: Text(
                        "Add Post",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
