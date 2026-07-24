import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/palette.dart';
import 'package:expense_tracker/screens/add_expense_screen.dart';
import 'package:expense_tracker/screens/summary_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> expenses = [];

  double get _total => expenses.fold(0, (sum, e) => sum + e.amount);

  void _deleteExpense(int index) {
    setState(() => expenses.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      floatingActionButton: FloatingActionButton.extended(onPressed: () async {
        final newExpense = await Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddExpenseScreen()),);
        if (newExpense != null) {
          setState(()=> expenses.add(newExpense));
        }
      }, 
      backgroundColor: Palette.accent,
      foregroundColor: Colors.white,
      elevation: 4,
      extendedPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: const StadiumBorder(),
      icon: const Icon(Icons.add,size:22),
      
      
      
      label: const Text('Add Expense',
      style: TextStyle(fontSize: 15,
      fontWeight: FontWeight.w600),)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 28, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(width: 40,
        height: 4,
        color: Palette.accent,),
        IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) => SummaryScreen(expenses: expenses)),
       ),); }, icon: const Icon(Icons.pie_chart_outline,
       color: Palette.muted,
       size:20)),
      ],),
      const SizedBox(height: 24,),
              const Text(
                'Your Expenses',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Palette.ink,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Palette.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Palette.hairline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total spent',
                      style: TextStyle(
                        fontSize: 13,
                        color: Palette.muted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${_total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Palette.accent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: expenses.isEmpty
                    ? Center(
                        child: Text(
                          'No expenses yet.',
                          style: TextStyle(
                            color: Palette.muted.withOpacity(0.8),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          final expense = expenses[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              expense.title,
                              style: const TextStyle(
                                color: Palette.ink,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              expense.category,
                              style: TextStyle(
                                fontSize: 13,
                                color: Palette.muted,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '\$${expense.amount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Palette.ink,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _deleteExpense(index),
                                  icon: const Icon(
                                    Icons.close,
                                    size: 18,
                                    color: Palette.muted,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const Divider(color: Palette.hairline, height: 1),
                        itemCount: expenses.length,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
