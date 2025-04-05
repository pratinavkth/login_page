import 'package:flutter/material.dart';
import 'package:login_page/expense_tracker/service/expense_service.dart';
import 'package:login_page/profile/profileScreen/profilescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final _amountController = TextEditingController();
  final  _categoryController = TextEditingController();
  final  _descriptionController = TextEditingController();
  final  _dateController = TextEditingController();
  final _formkey =GlobalKey<FormState>();

  @override
  void dispose() {
    print("dispose initiated");
    _amountController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> saveData() async {
    final String amountu = _amountController.text;
    final String descriptionu = _descriptionController.text;
    final String categoryu = _categoryController.text;
    final String dateu = _dateController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user');
    if (userId == null) {
      print("user id is null");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User id is null"))
      );
      return; // Add return to exit function if userId is null
    }

    // Check if both amount and date are filled
    if (amountu.isEmpty || dateu.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Amount and date are required"))
      );
      return; // Exit function if validation fails
    }

    // Only reach here if all validations pass
    await ExpenseService().addExpense(
        context: context,
        amount: amountu,
        description: descriptionu,
        category: categoryu,
        date: dateu);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Expense added successfully"))
    );

    // Clear form fields after successful submission
    _amountController.clear();
    _descriptionController.clear();
    _categoryController.clear();
    _dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.05),
        child: AppBar(
          shape: const Border(bottom: BorderSide(color: Colors.grey)),
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.03),
              child: const ImageIcon(
                AssetImage("assets/logo_noteit.png"),
                size: 100,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Profilescreen()));
              },
              icon: const Icon(Icons.account_circle_outlined),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView( // Added to handle keyboard overflow
          child: Padding( // Added padding for better layout
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'How Much?',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w900
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(

                        '₹',
                        style: TextStyle(
                            fontSize: 45, fontWeight: FontWeight.w800),
                      ),
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.w900
                          ),

                          key: _formkey,
                          controller: _amountController,
                          keyboardType: TextInputType.number, // Added for numeric keyboard
                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal:screenWidth*0.03 ),
                            hintText: ' 0.00',
                            hintStyle: const TextStyle(
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: screenHeight * 0.23, // Slightly increased for better spacing
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      children: [
                        TextField(
                          controller: _descriptionController,
                          enableInteractiveSelection: true,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.description,
                              color: Colors.white,
                            ),
                            iconColor: Colors.white,
                            labelText: "Description",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        TextFormField(
                          controller: _categoryController,
                          enableInteractiveSelection: true,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.category,
                              color: Colors.white,
                            ),
                            labelText: 'Category',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        TextField(
                          controller: _dateController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.date_range_outlined,
                              color: Colors.white,
                            ),
                            labelText: 'Date',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            _selectDate();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                SizedBox(
                  width: screenWidth * 0.5, // Set width for button
                  height: 50, // Set height for button
                  child: ElevatedButton(
                    onPressed: () {
                      saveData();
                      print("Button pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Add Expense',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }
}