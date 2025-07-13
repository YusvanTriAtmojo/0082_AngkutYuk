import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:angkut_yuk/core/color/color.dart';

Future<void> showCustomCupertinoDateTimePicker({
  required BuildContext context,
  required DateTime? currentDateTime,
  required void Function(DateTime selectedDateTime) onDateSelected,
}) async {
  DateTime now = DateTime.now();
  DateTime tempDateTime = currentDateTime != null && currentDateTime.isAfter(now)
      ? currentDateTime
      : now;

  await showCupertinoModalPopup(
    context: context,
    builder: (context) => Container(
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pilih Tanggal & Waktu Jemput',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: tempDateTime,
              minimumDate: now,
              maximumDate: now.add(Duration(days: 365)),
              use24hFormat: true,
              onDateTimeChanged: (DateTime newDate) {
                tempDateTime = newDate;
              },
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Warna.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: Text('Pilih'),
            onPressed: () {
              onDateSelected(tempDateTime);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ),
  );
}
