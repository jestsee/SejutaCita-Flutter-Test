import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../models/repository-response.dart';

class RepositoryListItem extends StatelessWidget {
  const RepositoryListItem({Key? key, required this.item, required this.index})
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
                item.owner.avatarUrl,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      Text(
                        item.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                          'Create date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(item.createdAt)}'),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Watchers: ${item.watchersCount.toString()}'),
                    Text('Stars: ${item.stargazersCount.toString()}'),
                    Text('Forks: ${item.forksCount.toString()}'),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
