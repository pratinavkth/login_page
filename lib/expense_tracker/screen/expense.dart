import 'package:flutter/material.dart';
import 'package:login_page/expense_tracker/screen/expenses_home_page.dart';

class Expense extends StatefulWidget {
  const Expense({Key? key}) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.05),
          child: AppBar(
            // elevation: 0.1,
            shape: const Border(bottom: BorderSide(color: Colors.grey)),
            // title: const Text('Search Notes'),
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.03),
                child: IconButton(
                    onPressed: () {},
                    icon: Image.asset("assets/logo_noteit.png")),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  // showSearch(context: context, delegate: Searchbar());
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.account_circle_outlined),
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1,right: screenWidth *0.3),
              child: Column(
                children: [
                  
                  const Text(
                    'How Much ?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.2,
                    width: screenWidth * 0.5,
                    child: Row(
                      children: [
                        const Text(
                          '₹',
                          style: TextStyle(
                              fontSize: 45, fontWeight: FontWeight.w800),
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: amountController,
                            decoration: const InputDecoration(
                              hintText: '0.00',
                              hintStyle: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1, left: screenWidth * 0.1, right: screenWidth * 0.1),
              
              child: Container(
                height: screenHeight * 0.2,
                width: screenWidth * 0.8,
               
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                // width: screenWidth * 0.8,
                child: Column(
                  children: [
                    TextField(
                      controller: descriptionController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Description',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextField(
                      controller: categoryController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Category',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const ExpensesHomePage();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Add Expense',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            )
          ],
        )));
  }
}
