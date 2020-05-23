import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print("build() TransactionList");
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constarints) {
            return Column(
              children: <Widget>[
                Text(
                  "No transaction added yet !",
                  style: Theme.of(context).textTheme.title,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: constarints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        // key'i kullanmak için Listview.builderı kullanmadık.(Listview.builder()da key kullanırken bug oluyor)
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTx: deleteTx,
                    ))
                .toList());
      // Listede 50 veya 100'den fazla item varsa listeyi bu şekilde oluşturarak performansı arttırabiliriz.
    // : ListView.builder(
    //     itemBuilder: (ctx, index) {
    //       return TransactionItem(
    //         key: ValueKey(transactions[index].id),
    //         transaction: transactions[index],
    //         deleteTx: deleteTx,
    //       );
    //     },
    //     itemCount: transactions.length,
    //   );
  }
}
