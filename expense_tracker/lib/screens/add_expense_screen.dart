import 'package:flutter/material.dart';
import '../palette.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String selectedCategory = 'Food';

  final categories = const ['Food', 'Transport', 'Shopping', 'Bills', 'Other'];

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _save() {
    final title = titleController.text.trim();
    final amount = double.tryParse(amountController.text.trim());

    if (title.isEmpty || amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a title and a valid amount')),
      );
      return;
    }

    final expense = Expense(
      title: title,
      amount: amount,
      category: selectedCategory,
    );

    Navigator.pop(context, expense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 28, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Palette.ink),
              ),
              const SizedBox(height: 12),
              Container(width: 40, height: 4, color: Palette.accent),
              const SizedBox(height: 28),
              const Text(
                'Add expense',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Palette.ink,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 36),
              TextField(
                controller: titleController,
                style: const TextStyle(color: Palette.ink, fontSize: 15),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Palette.muted),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Palette.hairline),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Palette.accent, width: 1.4),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const SizedBox(height: 28),
              TextField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: const TextStyle(color: Palette.ink, fontSize: 15),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$ ',
                  labelStyle: TextStyle(color: Palette.muted),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Palette.hairline),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Palette.accent, width: 1.4),
                  ),
                ),
              ),
              const SizedBox(height: 28,),
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 13,
                  color: Palette.muted,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: categories.map((c) {
                  final selected = c == selectedCategory;
                  return ChoiceChip(
                    label: Text(c),
                    selected: selected,
                    onSelected: (_) => setState(() => selectedCategory = c),
                    selectedColor: Palette.accent,
                    backgroundColor: Palette.surface,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Palette.ink,
                    ),
                    side: BorderSide(
                      color: selected ? Palette.accent : Palette.hairline,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }).toList(),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.accent,
                    foregroundColor: Colors.white,
                    elevation: 0.3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save expense',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
