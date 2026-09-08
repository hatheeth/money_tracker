import 'package:flutter/material.dart';
import '../util/date_picker.dart';

class AddExpensePage extends StatefulWidget {
  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  // These variables hold the "State" (the user's input)
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _payeeController = TextEditingController();
  final TextEditingController _note = TextEditingController();
  String? _selectedCategory;
  DateTime? _selectedDate = null;
  DateTime date = DateTime.now();
  final List<String> categories = ["Food", "Juice", "Fruite"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController, // Binds the input to the state
              decoration: InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              keyboardType: TextInputType.number,
            ),

            // ... other fields like Payee, Category Dropdown, Date Picker
            SizedBox(height: 20),
            TextField(
              controller: _payeeController,
              decoration: InputDecoration(
                labelText: "Payee",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _note,
              decoration: InputDecoration(
                labelText: "Note",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: const Text("Date"),
                subtitle: Text(
                  _selectedDate != null
                      ? '${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}'
                      : 'Select Date',
                ),
                leading: Icon(Icons.calendar_month),
                onTap: () async {
                  final pickedDate = await DatePickerHelper.selectDate(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(date.year),
                    lastDate: DateTime(2030),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 250,
              decoration: BoxDecoration(),
              child: DropdownButton<String>(
                hint: const Text("Select a Category"),
                value: _selectedCategory,
                items: categories.map((String categories) {
                  return DropdownMenuItem<String>(
                    value: categories,
                    child: Text(categories),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 1. Save the data to your database/list here
                // 2. Then go back:
                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text(
                "Save Expense",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
