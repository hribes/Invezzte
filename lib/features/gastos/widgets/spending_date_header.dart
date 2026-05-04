import 'package:flutter/material.dart';

class SpendingDateHeader extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged; // Função callback

  const SpendingDateHeader({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = 
        "${selectedDate.day.toString().padLeft(2, '0')}/"
        "${selectedDate.month.toString().padLeft(2, '0')}/"
        "${selectedDate.year}";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            formattedDate,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: const Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFFFCE7A1),
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      // Em vez de setState, executa a função que o Cérebro passou
      onDateChanged(picked); 
    }
  }
}