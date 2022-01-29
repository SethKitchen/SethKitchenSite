import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HTMLComp extends StatelessWidget {
  Widget src;

  HTMLComp(
      {Key? key,
        int? index,
        int? columns,
        int? rows,
        ValueChanged<List>? onSelectedItemChanged,
        int? maxSize,
        bool? isSelected,
        ValueChanged<int>? onTapped,
        required this.src})
      : super(
      key: key);

  Widget addConfigPaddingIfNecessary(Widget toAdd) {
    return toAdd;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    widgets.addAll([
      // Not actually rendered but needed for create state.
      addConfigPaddingIfNecessary(src)
    ]);

    return Stack(children: widgets);
  }
}