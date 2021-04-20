import 'package:flutter/material.dart';
import 'package:graphql_demo/config.dart';
import 'package:graphql_demo/widgets/myAlertDialog.dart';
import 'package:graphql_demo/widgets/myTextField.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// ignore: must_be_immutable
class UpdateScreen extends StatefulWidget {
  String id;
  String title;
  String postBody;

  UpdateScreen(this.id, this.title, this.postBody);
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool titleValidate = false;
  bool bodyValidate = false;
  String myResult;
  String updatePost = """
  mutation (
  \$id: ID!,
  \$input: UpdatePostInput!
) {
  updatePost(id: \$id, input: \$input) {
    id
    body
  }
}
  
  
  """;

  String deletePost = """
  mutation (
  \$id: ID!
) {
  deletePost(id: \$id)
}

  
  
  """;

  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update Post"),
        ),
        body: Mutation(
          options: MutationOptions(
              documentNode: gql(updatePost),
              onCompleted: (dynamic resultUpdateData) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return MyAlertDialog(
                          "Post Updated", resultUpdateData.toString());
                    });
              }),
          builder: (RunMutation runMutationUpdate, QueryResult resultUpdate,
              {fetchMore, refetch}) {
            return Mutation(
                options: MutationOptions(
                    documentNode: gql(deletePost),
                    onCompleted: (dynamic resultDeleteData) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return MyAlertDialog(
                                "Post deleted", resultDeleteData.toString());
                          });
                    }),
                builder:
                    (RunMutation runMutationDelete, QueryResult resultDelete) {
                  return Container(
                    color: MainColors.backgroundColor2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: phoneSize.width * .05,
                                bottom: phoneSize.height * .01),
                            child: Text(
                              "Edit Post",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        topPostCard(phoneSize),
                        MyTextField(
                            titleController, "Title", phoneSize, titleValidate),
                        MyTextField(bodyController, "What's going on",
                            phoneSize, bodyValidate),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: phoneSize.width * .35,
                              decoration: BoxDecoration(
                                  color: MainColors.mainOrange,
                                  borderRadius: BorderRadius.circular(15)),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    titleController.text.isEmpty
                                        ? titleValidate = true
                                        : titleValidate = false;
                                    bodyController.text.isEmpty
                                        ? bodyValidate = true
                                        : bodyValidate = false;
                                  });
                                  if (titleValidate == false) {
                                    if (bodyValidate == false) {
                                      runMutationUpdate({
                                        "id": widget.id,
                                        "input": {
                                          "body": bodyController.text,
                                          "title": titleController.text,
                                        }
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: phoneSize.width * .35,
                              decoration: BoxDecoration(
                                color: MainColors.mainOrange,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  runMutationDelete({"id": widget.id});
                                  print(resultDelete.data);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return MyAlertDialog("PostDeleted",
                                            resultDelete.data.toString());
                                      });
                                },
                                child: Center(
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }

  topPostCard(Size phoneSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: phoneSize.width * .05),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: phoneSize.width * .05,
                  vertical: phoneSize.height * .02),
              child: Container(
                width: phoneSize.width * .8,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: phoneSize.width * .05),
              child: Divider(
                color: MainColors.mainOrange,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: phoneSize.width * .05,
                  vertical: phoneSize.height * .02),
              child: Text(
                widget.postBody,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ),
    );
  }
}
