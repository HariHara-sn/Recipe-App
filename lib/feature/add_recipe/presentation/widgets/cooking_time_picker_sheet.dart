import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CookingTimePicker extends StatefulWidget {
  final int initialTotalMinutes;
  final ValueChanged<int> onTimeSelected;

  const CookingTimePicker({
    super.key,
    required this.initialTotalMinutes,
    required this.onTimeSelected,
  });

  @override
  State<CookingTimePicker> createState() => _CookingTimePickerState();
}

class _CookingTimePickerState extends State<CookingTimePicker> {
  late int _selectedHours;
  late int _selectedMinutes;

  @override
  void initState() {
    super.initState();
    _selectedHours = widget.initialTotalMinutes ~/ 60;
    _selectedMinutes = widget.initialTotalMinutes % 60;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.white,
      child: Column(
        children: [
          // Header with Done button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Set Cooking Time',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onTimeSelected(_selectedHours * 60 + _selectedMinutes);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3D3A8C),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // The Picker
          Expanded(
            child: Stack(
              children: [
                // Selection Bar Background
                Center(
                  child: Container(
                    height: 48,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                // The Wheels
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Hours Wheel
                    SizedBox(
                      width: 100,
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(initialItem: _selectedHours),
                        itemExtent: 40,
                        onSelectedItemChanged: (index) => setState(() => _selectedHours = index),
                        children: List.generate(24, (i) => Center(
                          child: Text(
                            '$i',
                            style: const TextStyle(fontSize: 22, color: Color(0xFF1A1A2E)),
                          ),
                        )),
                      ),
                    ),
                    const Text('hours', style: TextStyle(fontSize: 16, color: Colors.black)),
                    const SizedBox(width: 20),
                    // Minutes Wheel
                    SizedBox(
                      width: 100,
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(initialItem: _selectedMinutes),
                        itemExtent: 40,
                        onSelectedItemChanged: (index) => setState(() => _selectedMinutes = index),
                        children: List.generate(60, (i) => Center(
                          child: Text(
                            '$i',
                            style: const TextStyle(fontSize: 22, color: Color(0xFF1A1A2E)),
                          ),
                        )),
                      ),
                    ),
                    const Text('min.', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
