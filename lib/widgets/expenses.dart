import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_expensive_app/models/expenses.dart';
import 'package:my_expensive_app/widgets/chart/chart.dart';
import 'package:my_expensive_app/widgets/expenses_list/expenses_list.dart';
import 'package:my_expensive_app/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: '대봉찜닭',
        amount: 26000,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: '플러터 강의 수강',
        amount: 40000,
        date: DateTime.now(),
        category: Category.work),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('소비 내역이 삭제됐어요'),
        action: SnackBarAction(
            label: '취소하기',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('소비 내역을 추가해주세요'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesLists(
        expense: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('지출 계산기'),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Column(
          children: [
            Chart(expenses: _registeredExpenses),
            Expanded(child: mainContent),
          ],
        ),
      ),
    );
  }
}
