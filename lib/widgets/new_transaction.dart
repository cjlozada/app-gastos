import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDate() {
    showDatePicker(
      context: context,
      locale: const Locale('es', ''),
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
              controller: _titleController,
            ),
            TextField(
              decoration:
                  InputDecoration(labelText: 'Precio (decimales con punto)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
              ],
              onSubmitted: (_) => _submitData(),
              controller: _amountController,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Sin fecha elegida'
                          : DateFormat('dd-MM-yyyy').format(_selectedDate!),
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDate,
                    child: Text('Añadir fecha'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text('Añadir'),
              onPressed: _submitData,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                padding: MaterialStateProperty.all(
                    EdgeInsets.fromLTRB(40, 5, 40, 5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
