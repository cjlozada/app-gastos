import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pagos',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Quicksand',
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es', ''),
      ],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTrx = [
    //  Transaction(
    //    id: 't1',
    //    title: 'New shoes',
    //    money: 69.99,
    //    date: DateTime.now(),
    //  ),
    //  Transaction(
    //    id: 't2',
    //    title: 'Groceries',
    //    money: 16.53,
    //    date: DateTime.now(),
    //  ),
  ];

  void _addNewTrx(
    String title,
    double amount,
    DateTime chosenDate,
  ) {
    final newTx = Transaction(
      title: title,
      money: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTrx.add(newTx);
    });
  }

  void _startAddNewTrx(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTrx),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTrax(String id) {
    setState(() {
      _userTrx.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pagos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box_rounded),
            onPressed: () => _startAddNewTrx(context),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            width: double.infinity,
            child: Card(
              color: Theme.of(context).primaryColorDark,
              child: Text(
                'Ejemplo'.toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 0,
            ),
            padding: EdgeInsets.all(10),
            color: Theme.of(context).primaryColorDark,
          ),
          TransactionList(_userTrx, _deleteTrax),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTrx(context),
      ),
    );
  }
}
