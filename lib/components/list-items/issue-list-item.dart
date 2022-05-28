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
      height: kListTileHeight,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCardRadius)),
        child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.user.avatarUrl,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        item.title,
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
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Text(item.state)
                  ],
                )
              ],
            )),
      ),
    );
  }
}
