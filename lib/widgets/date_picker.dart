import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerDialog extends StatefulWidget {
  final int selectedYear;
  final int selectedMonth;
  final int selectedDay;
  final Function(int year, int month, int day) onDateChanged;

  DatePickerDialog({
    required this.selectedYear,
    required this.selectedMonth,
    required this.selectedDay,
    required this.onDateChanged,
  });

  @override
  _DatePickerDialogState createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<DatePickerDialog> {
  late int selectedYear;
  late int selectedMonth;
  late int selectedDay;

  late List<int> years;
  late List<int> months;
  late List<int> days;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.selectedYear;
    selectedMonth = widget.selectedMonth;
    selectedDay = widget.selectedDay;

    years = List.generate(100, (index) => 2025 - index);
    months = List.generate(12, (index) => index + 1);
    _updateDays();
  }

  void _updateDays() {
    int daysInMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;
    days = List.generate(daysInMonth, (index) => index + 1);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        _buildPicker(
          initialItem: years.indexOf(selectedYear),
          items: years,
          onSelectedItemChanged: (index) {
            setState(() {
              selectedYear = years[index];
              _updateDays();
            });
          },
        ),
        _buildPicker(
          initialItem: months.indexOf(selectedMonth),
          items: months,
          onSelectedItemChanged: (index) {
            setState(() {
              selectedMonth = months[index];
              _updateDays();
            });
          },
        ),
        _buildPicker(
          initialItem: days.indexOf(selectedDay),
          items: days,
          onSelectedItemChanged: (index) {
            setState(() {
              selectedDay = days[index];
            });
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          widget.onDateChanged(selectedYear, selectedMonth, selectedDay);
          Navigator.pop(context);
        },
        child: Text('Done'),
      ),
    );
  }

  Widget _buildPicker({
    required int initialItem,
    required List<int> items,
    required ValueChanged<int> onSelectedItemChanged,
  }) {
    return Container(
      height: 200,
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: initialItem),
        itemExtent: 32.0,
        onSelectedItemChanged: onSelectedItemChanged,
        children: List.generate(
          items.length,
          (index) => Center(child: Text(items[index].toString())),
        ),
      ),
    );
  }
}

// How to use
//  onPressed: () {
//                 showCupertinoModalPopup(
//                   context: context,
//                   builder: (_) => DatePickerDialog(
//                     selectedYear: selectedYear,
//                     selectedMonth: selectedMonth,
//                     selectedDay: selectedDay,
//                     onDateChanged: (year, month, day) {
//                       setState(() {
//                         selectedYear = year;
//                         selectedMonth = month;
//                         selectedDay = day;
//                       });
//                     },
//                   ),
//                 );
//               },
