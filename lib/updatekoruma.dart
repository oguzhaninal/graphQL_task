// import 'package:flutter/material.dart';
// import 'package:graphql_demo/config.dart';
// import 'package:graphql_demo/widgets/myAlertDialog.dart';
// import 'package:graphql_demo/widgets/myTextField.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// // ignore: must_be_immutable
// class UpdateScreen extends StatefulWidget {
//   String id;
//   String title;
//   String postBody;

//   UpdateScreen(this.id, this.title, this.postBody);
//   @override
//   _UpdateScreenState createState() => _UpdateScreenState();
// }

// class _UpdateScreenState extends State<UpdateScreen> {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController bodyController = TextEditingController();
//   bool titleValidate = false;
//   bool bodyValidate = false;

//   String updatePost = """
//   mutation (
//   \$id: ID!,
//   \$input: UpdatePostInput!
// ) {
//   updatePost(id: \$id, input: \$input) {
//     id
//     body
//   }
// }

//   """;

//   @override
//   Widget build(BuildContext context) {
//     Size phoneSize = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Update Post"),
//         ),
//         body: Mutation(
//           options: MutationOptions(
//             documentNode: gql(updatePost),
//           ),
//           builder: (RunMutation runMutationUpdate, QueryResult resultUpdate) {
//             return Container(
//               color: MainColors.backgroundColor2,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           left: phoneSize.width * .05,
//                           bottom: phoneSize.height * .01),
//                       child: Text(
//                         "Edit Post",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   topPostCard(phoneSize),
//                   MyTextField(
//                       titleController, "Title", phoneSize, titleValidate),
//                   MyTextField(
//                       bodyController, "Give Content", phoneSize, bodyValidate),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         width: phoneSize.width * .3,
//                         decoration: BoxDecoration(
//                             color: MainColors.mainOrange,
//                             borderRadius: BorderRadius.circular(15)),
//                         child: TextButton(
//                           onPressed: () {
//                             setState(() {
//                               titleController.text.isEmpty
//                                   ? titleValidate = true
//                                   : titleValidate = false;
//                               bodyController.text.isEmpty
//                                   ? bodyValidate = true
//                                   : bodyValidate = false;
//                             });
//                             if (titleValidate == false) {
//                               if (bodyValidate == false) {
//                                 runMutationUpdate({
//                                   "id": widget.id,
//                                   "input": {
//                                     "title": titleController.text,
//                                     "body": bodyController.text,
//                                   }
//                                 });
//                                 print(resultUpdate.data);
//                                 showDialog(
//                                   context: context,
//                                   // ignore: missing_return
//                                   builder: (context) {
//                                     return MyAlertDialog(
//                                       "Post Updated",
//                                       resultUpdate.data.toString(),
//                                     );
//                                   },
//                                 );
//                               }
//                             }
//                           },
//                           child: Text(
//                             "Update",
//                             style: TextStyle(
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   topPostCard(Size phoneSize) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: phoneSize.width * .05),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: phoneSize.width * .05,
//                   vertical: phoneSize.height * .02),
//               child: Container(
//                 width: phoneSize.width * .8,
//                 child: Text(
//                   widget.title,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: phoneSize.width * .05),
//               child: Divider(
//                 color: MainColors.mainOrange,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: phoneSize.width * .05,
//                   vertical: phoneSize.height * .02),
//               child: Text(
//                 widget.postBody,
//                 style: TextStyle(fontStyle: FontStyle.italic),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
