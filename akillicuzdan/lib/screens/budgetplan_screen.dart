// Bütçe planlama ekranı
import 'package:flutter/material.dart';

class BudgetPlanScreen extends StatefulWidget {
  const BudgetPlanScreen({super.key});

  @override
  _BudgetPlanScreenState createState() => _BudgetPlanScreenState();
}

class _BudgetPlanScreenState extends State<BudgetPlanScreen> {
  String selectedIncomeCategory = "Maaş";
  String selectedExpenseCategory = "Kira";
  final List<String> incomeCategories = ["Maaş", "Ek Gelir", "Yatırım"];
  final List<String> expenseCategories = [
    "Kira",
    "Yemek",
    "Ulaşım",
    "Eğlence",
    "Sağlık",
    "Kredi",
    "Diğer"
  ];

  final TextEditingController incomeController = TextEditingController();
  final TextEditingController expenseController = TextEditingController();
  final TextEditingController targetNameController = TextEditingController();
  final TextEditingController targetPriceController = TextEditingController();

  List<Map<String, dynamic>> incomeList = [];
  List<Map<String, dynamic>> expenseList = [];
  List<Map<String, dynamic>> targetsList = [];
  double totalIncome = 0;
  double totalExpense = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Bütçe Planla", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 0, 60, 145),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF0047AB),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildIncomeCard(),
              const SizedBox(height: 20),
              _buildExpenseCard(),
              const SizedBox(height: 20),
              _buildTargetCard(),
              const SizedBox(height: 20),
              _buildResultCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIncomeCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Gelir Hesaplama",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0047AB)),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: incomeController,
              decoration: const InputDecoration(
                labelText: "Gelir Tutarı",
                labelStyle: TextStyle(color: Color(0xFF0047AB)),
              ),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: selectedIncomeCategory,
              dropdownColor: Colors.white,
              iconEnabledColor: const Color(0xFF0047AB),
              style: const TextStyle(color: Color(0xFF0047AB)),
              onChanged: (String? newValue) {
                setState(() {
                  selectedIncomeCategory = newValue!;
                });
              },
              items: incomeCategories
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: const TextStyle(color: Color(0xFF0047AB))),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _addIncome,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0047AB),
                foregroundColor: Colors.white,
              ),
              child: const Text("Gelir Ekle"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Gider Hesaplama",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0047AB)),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: expenseController,
              decoration: const InputDecoration(
                labelText: "Gider Tutarı",
                labelStyle: TextStyle(color: Color(0xFF0047AB)),
              ),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: selectedExpenseCategory,
              dropdownColor: Colors.white,
              iconEnabledColor: const Color(0xFF0047AB),
              style: const TextStyle(color: Color(0xFF0047AB)),
              onChanged: (String? newValue) {
                setState(() {
                  selectedExpenseCategory = newValue!;
                });
              },
              items: expenseCategories
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: const TextStyle(color: Color(0xFF0047AB))),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _addExpense,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0047AB),
                foregroundColor: Colors.white,
              ),
              child: const Text("Gider Ekle"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTargetCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hedef Belirleme",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0047AB)),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: targetNameController,
              decoration: const InputDecoration(
                labelText: "Hedef İsmi",
                labelStyle: TextStyle(color: Color(0xFF0047AB)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: targetPriceController,
              decoration: const InputDecoration(
                labelText: "Hedef Fiyatı",
                labelStyle: TextStyle(color: Color(0xFF0047AB)),
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _addTarget,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0047AB),
                foregroundColor: Colors.white,
              ),
              child: const Text("Hedef Ekle"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sonuçlar",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0047AB)),
            ),
            const SizedBox(height: 20),
            Text("Toplam Gelir: ₺${totalIncome.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.green)),
            Text("Toplam Gider: ₺${totalExpense.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            const Text(
              "Sonuç:",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0047AB)),
            ),
            if (totalIncome - totalExpense >= 0)
              Text(
                  "Kalan Bütçe: ₺${(totalIncome - totalExpense).toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.green))
            else
              Text(
                  "Açık Bütçe: ₺${(totalIncome - totalExpense).toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            ..._buildIncomeCards(),
            ..._buildExpenseCards(),
            ..._buildTargetCards(),
          ],
        ),
      ),
    );
  }

  void _addIncome() {
    double income = double.tryParse(incomeController.text) ?? 0;
    setState(() {
      totalIncome += income;
      incomeList.add({
        'category': selectedIncomeCategory,
        'amount': income,
      });
      incomeController.clear();
    });
  }

  void _addExpense() {
    double expense = double.tryParse(expenseController.text) ?? 0;
    setState(() {
      totalExpense += expense;
      expenseList.add({
        'category': selectedExpenseCategory,
        'amount': expense,
      });
      expenseController.clear();
    });
  }

  void _addTarget() {
    double targetPrice = double.tryParse(targetPriceController.text) ?? 0;
    double monthlySavings = targetPrice / 12; // Aylık birikim ihtiyacı
    setState(() {
      targetsList.add({
        'name': targetNameController.text,
        'price': targetPrice,
        'monthlySavings': monthlySavings,
      });
      targetNameController.clear();
      targetPriceController.clear();
    });
  }

  List<Widget> _buildIncomeCards() {
    return incomeList.map((income) {
      return Card(
        color: Colors.green[100],
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(income['category'],
                  style: const TextStyle(color: Colors.black)),
              Text("₺${income['amount'].toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.black)),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    totalIncome -= income['amount'];
                    incomeList.remove(income);
                  });
                },
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildExpenseCards() {
    return expenseList.map((expense) {
      return Card(
        color: Colors.red[100],
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(expense['category'],
                  style: const TextStyle(color: Colors.black)),
              Text("₺${expense['amount'].toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.black)),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    totalExpense -= expense['amount'];
                    expenseList.remove(expense);
                  });
                },
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildTargetCards() {
    return targetsList.map((target) {
      return Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(target['name'],
                  style: const TextStyle(color: Color(0xFF0047AB))),
              Text("₺${target['price'].toStringAsFixed(2)}",
                  style: const TextStyle(color: Color(0xFF0047AB))),
              Text(
                  "Aylık Gereken: ₺${target['monthlySavings'].toStringAsFixed(2)}",
                  style: const TextStyle(color: Color(0xFF0047AB))),
            ],
          ),
        ),
      );
    }).toList();
  }
}