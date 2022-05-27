import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sejuta_cita_test/constants.dart';

import '../../models/issue-response.dart';

class IssueListItem extends StatelessWidget {
  const IssueListItem({Key? key, required this.item, required this.index})
      : super(key: key);

  final Item item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constant.listTileHeight,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constant.cardRadius)),
        child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.user.avatarUrl,
                // height: 0.095 * size.width,
                // width: 0.095 * size.width,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(index.toString()),
                      Text(
                        '$index. ${item.title}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                          'Last update: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(item.updatedAt)}'),
                    ],
                  ),
                ),
                Column(
                  children: [Text(item.state)],
                )
              ],
            )),
      ),
    );
  }
}
