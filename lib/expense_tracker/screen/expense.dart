import 'package:flutter/material.dart';
class Expense extends StatefulWidget {
  const Expense({Key? key}) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.05),
        
      child:AppBar(
        // elevation: 0.1,
        shape: const Border(bottom: BorderSide(color: Colors.grey)),
        // title: const Text('Search Notes'),
        backgroundColor: Colors.white,
        actions: [
          Padding(padding: EdgeInsets.only(left: screenWidth * 0.03),
          child:IconButton(onPressed: (){}, icon: Image.asset("assets/logo_noteit.png")),),
          Spacer(),
          IconButton(
            onPressed: (){
              // showSearch(context: context, delegate: Searchbar());
            
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      ),
      body: const Center(
        child: Text('Audio Screen'),
      ),
    );
  }
}