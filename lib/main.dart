import 'package:esercizio2_udemy/widget/chart.dart';
import 'package:esercizio2_udemy/widget/transaction_list.dart';
import 'package:flutter/material.dart';
import 'widget/new_transaction.dart';
import 'models/transaction.dart';
import 'widget/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista Spese',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'nike air max 97',
    //   amount: 179.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'nike air force 1',
    //   amount: 109.99,
    //   date: DateTime.now(),
    // )
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((transaction){
      print(transaction);
      return transaction.date.isAfter(
          DateTime.now().subtract(
              Duration(days: 7),
          ),
      );
    }).toList();
  }

  void _addNewTransaction(String transactionTitle, double transactionAmount, DateTime chosenDate) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: transactionTitle,
      amount: transactionAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void startAddNewTransaction(BuildContext transaction) {
    showModalBottomSheet(context: transaction, builder: (_){
        return GestureDetector(
          onTap:(){},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        ) ;
    },);
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Spese'),
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chart(_recentTransaction),
          TransactionList(_userTransactions, _deleteTransaction),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
