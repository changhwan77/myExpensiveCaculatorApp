import 'package:flutter/material.dart';
import 'package:my_expensive_app/models/expenses.dart';
import 'package:my_expensive_app/widgets/expenses_list/expenses_item.dart';

class ExpensesLists extends StatelessWidget {
  const ExpensesLists(
      {super.key, required this.expense, required this.onRemoveExpense});
  final List<Expense> expense;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expense[index]);
        },
        key: ValueKey(expense[index]),
        child: ExpenseItem(expense[index]),
      ),
    );
  }
}
