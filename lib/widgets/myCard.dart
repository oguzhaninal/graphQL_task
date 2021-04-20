import 'package:flutter/material.dart';
import 'package:graphql_demo/config.dart';

// ignore: must_be_immutable
class MyPostCard extends StatelessWidget {
  Size phoneSize;
  String title;
  String body;
  Function function;
  MyPostCard(this.phoneSize, this.title, this.body, this.function);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    // bottom: phoneSize.height * .006,
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: phoneSize.width * .65,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: phoneSize.width * .035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: phoneSize.height * .01,
                ),
                child: Container(
                  width: phoneSize.width * .8,
                  child: Text(
                    body,
                    style: TextStyle(
                      fontSize: phoneSize.width * .03,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
