import 'package:flutter/material.dart';
import 'package:sejuta_cita_test/models/user-response.dart';

import '../../constants.dart';

class UsersListItem extends StatelessWidget {
  const UsersListItem({Key? key, required this.item, required this.index}) : super(key: key);

  final UserItem item;
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
                item.avatarUrl,
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
                        '$index. ${item.login}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
