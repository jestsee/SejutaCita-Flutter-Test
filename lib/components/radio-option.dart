import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/app_bloc.dart';
import 'package:sejuta_cita_test/constants.dart';

class RadioOption extends StatefulWidget {
  final bool homePage;

  const RadioOption({Key? key, this.homePage = false}) : super(key: key);

  @override
  State<RadioOption> createState() => _RadioOptionState();
}

class _RadioOptionState extends State<RadioOption> {
  int selectedValue = -1;

  @override
  Widget build(BuildContext context) {
    var state = context.read<AppBloc>().state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RadioItem(
          text: "Users",
          value: 1,
          onChanged: (value) {
            setState(() => selectedValue = value!);
            context
                .read<AppBloc>()
                .add(const ChangeSearchTypeEvent(SearchType.users));

            if (!widget.homePage) {
              context.read<AppBloc>().add(NewQueryEvent(state.query));
            }
          },
          groupValue: selectedValue,
        ),
        RadioItem(
          text: "Issues",
          value: 2,
          onChanged: (value) {
            setState(() => selectedValue = value!);
            context
                .read<AppBloc>()
                .add(const ChangeSearchTypeEvent(SearchType.issues));

            if (!widget.homePage) {
              context.read<AppBloc>().add(NewQueryEvent(state.query));
            }
          },
          groupValue: selectedValue,
        ),
        RadioItem(
          text: "Repositories",
          value: 3,
          onChanged: (value) {
            setState(() => selectedValue = value!);
            context
                .read<AppBloc>()
                .add(const ChangeSearchTypeEvent(SearchType.repositories));

            if (!widget.homePage) {
              context.read<AppBloc>().add(NewQueryEvent(state.query));
            }
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
