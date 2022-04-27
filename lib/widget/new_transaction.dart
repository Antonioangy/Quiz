import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  late String titleInput;
  late String amountInput;
  late DateTime? _selectedDate = null;


  void submitData(){

    final enteredTitle = titleInput;
    final enteredAmount = double.parse(amountInput);

    if (enteredTitle.isEmpty || enteredAmount <=0){
      return;
    }


    widget.addTransaction(
      titleInput,
      double.parse(amountInput),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;

      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(decoration: InputDecoration(labelText: 'Title'),
              onChanged: (val){
                titleInput = val;
              },
            ),
            TextField(decoration: InputDecoration(labelText: 'Amount'),
              onChanged: (val){
                amountInput = val;
              },
              keyboardType: TextInputType.number,
              onSubmitted:(_) => submitData ,
            ),
            SizedBox(height: 30),
            Row(children: [

              Text(_selectedDate == null
                  ? "Date is not selected yet      "
                  : DateFormat.yMd().format(_selectedDate!)),
              TextButton(
                child: Text(
                  'Choose Date',
                  style: TextStyle(
                      fontWeight: FontWeight.bold),
                  ),
                onPressed:_presentDatePicker,
              )
            ],),
            TextButton(
              onPressed: submitData,
              child: Text('Add Transaction'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.indigo[900],
                primary: Colors.blue[100]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
