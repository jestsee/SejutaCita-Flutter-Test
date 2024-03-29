import 'package:flutter/material.dart';
import 'package:sejuta_cita_test/models/user-response.dart';

import '../../constants.dart';

class UsersListItem extends StatelessWidget {
  const UsersListItem({Key? key, required this.item, required this.index})
      : super(key: key);

  final UserItem item;
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
                item.avatarUrl,
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.login,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ), const SizedBox(width: 1),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
