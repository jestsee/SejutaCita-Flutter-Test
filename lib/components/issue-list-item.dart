import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/issue-response.dart';

class IssueListItem extends StatelessWidget {
  const IssueListItem({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(item.updatedAt)),
              ],
            ),
          ),
          Column(
            children: [Text(item.state)],
          )
        ],
      )),
    );
  }
}
