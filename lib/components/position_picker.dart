import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PositionPicker extends StatelessWidget {
  final int hour;
  final int minute;
  final Function onChangeHour;
  final Function onChangeMin;

  const PositionPicker({
    super.key,
    required this.hour,
    required this.minute,
    required this.onChangeHour,
    required this.onChangeMin,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: CupertinoPicker(
            itemExtent: 40,
            onSelectedItemChanged: (value) async {
              onChangeHour(value);
              await HapticFeedback.lightImpact();
            },
            looping: true,
            squeeze: 1,
            magnification: 1.2,
            scrollController: FixedExtentScrollController(
              initialItem: hour,
            ),
            children: List.generate(
              30,
              (index) => Text(
                '$index',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const Text(
          " : ",
          style: TextStyle(fontSize: 40),
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: CupertinoPicker(
            itemExtent: 40,
            onSelectedItemChanged: (value) async {
              onChangeMin(value);
              await HapticFeedback.selectionClick();
            },
            looping: true,
            squeeze: 1,
            magnification: 1.2,
            scrollController: FixedExtentScrollController(initialItem: minute),
            children: List.generate(
              30,
              (index) => Text(
                index < 10 ? '0$index' : '$index',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
