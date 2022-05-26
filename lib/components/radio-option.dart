import "package:flutter/material.dart";

class RadioOption extends StatelessWidget {
  const RadioOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RadioItem(text: "User", value: -1,),
        RadioItem(text: "Issues", value: -1,),
        RadioItem(text: "Repositories", value: -1,),
      ],
    );
  }
}

class RadioItem extends StatelessWidget {
  final String text;
  final int value;
  const RadioItem({Key? key, required this.text, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio(
            value: value,
            groupValue: 1,
            onChanged: (value) {}
        ), Text(text),
      ],
    );
  }
}

