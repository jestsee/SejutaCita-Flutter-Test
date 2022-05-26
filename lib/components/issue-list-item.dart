import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sejuta_cita_test/constants.dart';

import '../models/issue-response.dart';

class IssueListItem extends StatelessWidget {
  const IssueListItem({Key? key, required this.item, required this.index}) : super(key: key);

  final Item item;
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: Constant.listTileHeight, // TODO nanti ganti
      child: ListTile(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(index.toString()),
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
