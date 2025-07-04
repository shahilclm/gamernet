import 'package:flutter/material.dart';

class DatePickerScreen extends StatefulWidget {
  @override
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  String? selectedMonth;
  int? selectedYear;
  int? selectedDay;

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<int> years = List.generate(100, (index) => DateTime.now().year - index);

  @override
  void initState() {
    super.initState();
    selectedYear = DateTime.now().year - 18;
    selectedMonth = months[DateTime.now().month - 1];
    selectedDay = DateTime.now().day;
  }

  @override
  Widget build(BuildContext context) {
    List<int> days = _getDaysInMonth(selectedMonth, selectedYear);

    return Container(
      height: 300,
      width: 400, // Set a fixed width
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xff272738), // Background color of the container
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date of birth',
            style: TextStyle(
                fontFamily: 'Orbitron',
                color: Colors.white70,
                fontSize: 20,
                letterSpacing: 1),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMonthDropdown(),
              SizedBox(width: 20),
              _buildDayDropdown(days),
              SizedBox(width: 20),
              _buildYearDropdown(),
            ],
          ),
          SizedBox(height: 50),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF932EFF))),
              onPressed: () {
                if (selectedDay != null &&
                    selectedMonth != null &&
                    selectedYear != null) {
                  Navigator.of(context).pop([
                    selectedDay!,
                    months.indexOf(selectedMonth!) + 1,
                    selectedYear!
                  ]);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a valid date.')),
                  );
                }
              },
              child: Text(
                'Done',
                style: TextStyle(color: Colors.white, fontFamily: 'Orbitron'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<int> _getDaysInMonth(String? month, int? year) {
    if (month == null || year == null) return [];

    switch (month) {
      case 'February':
        return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))
            ? List.generate(29, (index) => index + 1)
            : List.generate(28, (index) => index + 1);
      case 'April':
      case 'June':
      case 'September':
      case 'November':
        return List.generate(30, (index) => index + 1);
      default:
        return List.generate(31, (index) => index + 1);
    }
  }

  Widget _buildMonthDropdown() {
    return _buildDropdown<String>(
      hint: 'Month',
      value: selectedMonth,
      items: months,
      onChanged: (String? newValue) {
        setState(() {
          selectedMonth = newValue;
          _updateDayIfNeeded();
        });
      },
    );
  }

  Widget _buildDayDropdown(List<int> days) {
    return _buildDropdown<int>(
      hint: 'Day',
      value: selectedDay,
      items: days.map((day) => day.toString()).toList(),
      onChanged: (int? newValue) {
        setState(() {
          selectedDay = newValue;
        });
      },
      enabled: selectedMonth != null && selectedYear != null,
    );
  }

  Widget _buildYearDropdown() {
    return _buildDropdown<int>(
      hint: 'Year',
      value: selectedYear,
      items: years.map((year) => year.toString()).toList(),
      onChanged: (int? newValue) {
        setState(() {
          selectedYear = newValue;
          _updateDayIfNeeded();
        });
      },
    );
  }

  Widget _buildDropdown<T>({
    required String hint,
    required T? value,
    required List<String> items,
    required ValueChanged<T?> onChanged,
    bool enabled = true,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xff272738),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          style: TextStyle(color: Color(0xff81808D), fontFamily: 'Orbitron'),
          borderRadius: BorderRadius.circular(10),
          icon: Icon(Icons.keyboard_arrow_down),
          dropdownColor: Colors.grey.shade100,
          hint: Text(
            '  $hint',
            style: TextStyle(fontFamily: 'Orbitron', color: Color(0xff81808D)),
          ),
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<T>(
              value: (T == String) ? item as T : int.parse(item) as T,
              child: Text(item),
            );
          }).toList(),
          onChanged: enabled ? onChanged : null,
        ),
      ),
    );
  }

  void _updateDayIfNeeded() {
    if (selectedDay != null &&
        selectedDay! > _getDaysInMonth(selectedMonth, selectedYear).length) {
      selectedDay = _getDaysInMonth(selectedMonth, selectedYear).length;
    }
  }
}
