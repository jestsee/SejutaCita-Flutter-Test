import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/issue_bloc.dart';
import 'package:sejuta_cita_test/constants.dart';
import 'package:sejuta_cita_test/repository/issue-repository.dart';

class RadioOption extends StatefulWidget {
  const RadioOption({Key? key}) : super(key: key);

  @override
  State<RadioOption> createState() => _RadioOptionState();
}

class _RadioOptionState extends State<RadioOption> {
  int selectedValue = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RadioItem(
          text: "Users",
          value: 1,
          onChanged: (value) {
            setState(() => selectedValue = value!);
            // ganti repo yang sesuai
            context.read<IssueBloc>().add(GetNewIssueEvent("kuda"));
            // panggil context.read<IssueBloc>().add(GetNewIssueEvent(value))
          },
          groupValue: selectedValue,
        ),
        RadioItem(
          text: "Issues",
          value: 2,
          onChanged: (value) {
            setState(() => selectedValue = value!);
          },
          groupValue: selectedValue,
        ),
        RadioItem(
          text: "Repositories",
          value: 3,
          onChanged: (value) {
            setState(() => selectedValue = value!);
          },
          groupValue: selectedValue,
        ),
      ],
    );
  }
}

class RadioItem extends StatelessWidget {
  final String text;
  final int value;
  final int groupValue;
  final void Function(int?) onChanged;

  const RadioItem(
      {Key? key,
      required this.text,
      required this.value,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio(value: value, groupValue: groupValue, onChanged: onChanged),
        Text(text),
      ],
    );
  }
}
