import 'package:flutter/material.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  final PostList = [
    {'video' : '123'},
    {'video' : '123'},
    {'video' : '123'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: PostList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildListItem(PostList[index]),
              SizedBox(
                height: 20,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListItem(Map<String, String?> item) {
    return Container(
      child: Row(
        children: [

        ],
      ),
    );
  }
}
