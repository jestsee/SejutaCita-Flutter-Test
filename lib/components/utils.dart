import 'package:flutter/material.dart';
import 'package:sejuta_cita_test/components/list-items/issue-list-item.dart';
import 'package:sejuta_cita_test/components/list-items/repository-list-item.dart';
import 'package:sejuta_cita_test/components/list-items/users-list-item.dart';
import 'package:sejuta_cita_test/constants.dart';
import 'package:sejuta_cita_test/models/issue-response.dart';
import 'package:sejuta_cita_test/models/user-response.dart';

class Utils {
  static void scrollToIndex(int index, ScrollController sc) {
    sc.animateTo(kListTileHeight * (index - 1),
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  static Widget widgetDecider(item, int index) {
    if (item is Item) {
      return IssueListItem(item: item, index: index + 1);
    } else if (item is UserItem) {
      return UsersListItem(item: item, index: index + 1);
    } else {
      return RepositoryListItem(item: item, index: index + 1);
    }
  }
}
