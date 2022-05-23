import "package:flutter/material.dart";

class RadioOption extends StatelessWidget {
  const RadioOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("User"),
        Radio(
          value: 1,
          groupValue: 1,
          onChanged: (value) {}
        )
      ],
    );
  }
}
