import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.parse('0000-00-00');

  void _sumbitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickeData) {
      if (pickeData == null) {
        return;
      }

      setState(() {
        _selectedDate = pickeData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(child: Card(
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => _sumbitData()
                // onChanged: (val) {
                // titleInput = val;
                // },
                ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _sumbitData(),
              // onChanged: (val) => amountInput = val,
            ),
            Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(_selectedDate == null
                            ? 'NoDate Chosen'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)} ')),
                    FlatButton(
                      onPressed: () {
                        _presentDatePicker();
                      },
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                )),
            RaisedButton(
                onPressed: () {
                  _sumbitData();
                },
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white)
          ],
        ),
      ),
    ));
  }
}
