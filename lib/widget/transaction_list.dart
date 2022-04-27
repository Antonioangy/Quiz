import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';


class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty ?
        Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text('Nessuna spesa,,', style:TextStyle(fontSize: 20)),
            Container(
              height: 250,
                child: Image.asset(
                  'assets/images/snoopy_PNG37.png',
                  fit: BoxFit.cover,
                )
            ),
          ],
        )
      : ListView(
        children: transactions.map((Transaction)  {
          return Card(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: CircleAvatar(
                      radius: 35.0,
                      child: Text(
                        '\$${Transaction.amount.toStringAsFixed(2)}', //metto toStringAsFixed per avere i centesimi automaticamente, nel caso non li scrivessi
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),


                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        Transaction.title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.yMMMd().format(Transaction.date), //se voglio la data in modo piu' carino metto DateFormat.yMMMd().format(Transation.date)
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () => deleteTransaction(Transaction.id),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
