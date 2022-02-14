import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx);

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    addTx(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              controller: titleController,
            ),
            TextField(
              decoration:
                  InputDecoration(labelText: 'Precio (decimales con punto)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
              ],
              onSubmitted: (_) => submitData(),
              controller: amountController,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: ElevatedButton(
                child: Text('Añadir'),
                onPressed: submitData,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 33, 131, 243)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(40, 5, 40, 5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
