import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practico_postips/todo/provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget{
  const RadioWidget({
    super.key,
    required this.titleRadio,
    required this.cateColor,
    required this.valueInput,
    required this.onChangedValue,
  });

  final String titleRadio;
  final Color cateColor;
  final int valueInput;
  final VoidCallback onChangedValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio = ref.watch(radioProvider);
    return Material(
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: cateColor,
        ),
        child: RadioListTile(
            activeColor: cateColor,
            contentPadding: EdgeInsets.zero,
            title: Transform.translate(
                offset: Offset(-22,0),
                child:  Text(titleRadio, style:
                TextStyle(
                    color: cateColor,
                    fontWeight: FontWeight.w700,

                ),),
            ),
            value: valueInput,
            groupValue: radio,
            onChanged: (value)=>onChangedValue(),
        ),
      ),
    );
  }
}
