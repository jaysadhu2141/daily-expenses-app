import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty ? Column(children: <Widget>[
        Text('No Transaction Adeed Yet'),
        Container(
          height: 200,
          child: Image(image: AssetImage('assets/image/m.png')),
        ),
      ],
      )
      : ListView.builder(
          itemBuilder: (ctx, index){
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(leading: CircleAvatar(radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6),
              child: FittedBox(
              child: Text('\$${transactions[index].amount}'),
              ),
              ),
            ),
              title: Text(
                transactions[index].title,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
              ),
              trailing:
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.purple,
                onPressed: () => deleteTx(transactions[index].id),
               ),

            ),
            );
          },
        itemCount: transactions.length,


      ),

      );

  }
}
