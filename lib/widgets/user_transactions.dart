import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTrx = [
    Transaction(
      id: 't1',
      title: 'New shoes',
      money: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Groceries',
      money: 16.53,
      date: DateTime.now(),
    ),
  ];

  void _addNewTrx(
    String title,
    double amount,
  ) {
    final newTx = Transaction(
      title: title,
      money: amount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTrx.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTrx),
        TransactionList(_userTrx),
      ],
    );
  }
}
