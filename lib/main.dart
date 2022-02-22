import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_1/chart.dart';
import 'package:project_1/new_transaction.dart';
import 'package:project_1/transaction_list.dart';
import './models/transaction.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction>_userTransactions = [
   // Transaction(id: 't1', title: 'Shoes', amount: 78.99, date: DateTime.now(),),
    //Transaction(id: 't2', title: 'Shirt', amount: 35.99, date: DateTime.now(),),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
            Duration(days: 7),
        ),
      );
    }
    ).toList();
  }

  void _addNewTransaction(String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(title: txtitle,
      amount: txamount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }
    void _startAddNewTransaction(BuildContext ctx) {

      showModalBottomSheet(context: ctx, builder: (_) {
        return GestureDetector(
          onTap: (){},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },);
    }

    void _deleteTransaction(String id)
    {
      setState(() {
        _userTransactions.removeWhere((tx) => tx.id == id);
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Daily Expenses'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           chart(_recentTransactions),

            TransactionList(_userTransactions, _deleteTransaction),
          ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      );
    }
  }
