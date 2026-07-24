import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/palette.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key, required this.expenses});
  final List<Expense> expenses;

  Map<String, double> _groupByCategory() {
    final Map<String, double> totals = {};
    for (final expense in expenses) {
      totals[expense.category] =
          (totals[expense.category] ?? 0) + expense.amount;
    }
    return totals;
  }

  @override
  Widget build(BuildContext context) {
    final totals = _groupByCategory();
    final grandTotal = totals.values.fold(0.0, (sum, v) => sum + v);
    final sortedEntries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 28, 32),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [IconButton(padding: EdgeInsets.zero,
            onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back,
            color: Palette.ink,)),
            const SizedBox(height: 12,),
            Container(width: 40,
            height: 4,
            color: Palette.accent,),
            const SizedBox(height: 28,),
            
            const Text('Summary',
            style: TextStyle(
              color: Palette.ink,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5
            ),),
            const SizedBox(height: 8,),
            Text('\$${grandTotal.toStringAsFixed(2)} across ${expenses.length} expenses',
            style: const TextStyle(fontSize: 15,
            color: Palette.muted),),
            const SizedBox(height: 32,),
            Expanded(child: sortedEntries.isEmpty ? Center(child: Text('Add some expenses to see a breakdown.',
            style: TextStyle(color: Palette.muted.withOpacity(0.8),
            fontSize: 15),),): ListView.separated(itemCount: sortedEntries.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20,),
            itemBuilder: (context, index) {
              final entry = sortedEntries[index];
              final percent = grandTotal == 0 ? 0.0 : entry.value / grandTotal;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key,
                    style: const TextStyle(fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Palette.ink,),),
                    Text('\$${entry.value.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 15,
                    color: Palette.ink),)
                  ],),
                  const SizedBox(height: 8,),
                  ClipRRect(borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(value: percent,
                  minHeight: 10,
                  backgroundColor: Palette.hairline,
                  valueColor: const AlwaysStoppedAnimation(Palette.accent),),),
                  const SizedBox(height: 4,),
                  Text('${(percent * 100).toStringAsFixed(0)}% of total',
                  style: const TextStyle(fontSize: 12,color: Palette.muted),)
                ],
              );
            },))
            ],),
        ),
      ),
    );
  }
}
