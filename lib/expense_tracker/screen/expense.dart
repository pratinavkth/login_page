import 'package:flutter/material.dart';
import 'package:login_page/expense_tracker/screen/expenses_home_page.dart';

class Expense extends StatefulWidget {
  const Expense({Key? key}) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  @override
  void dispose() {
    _amountController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.05),
          child: AppBar(
            shape: const Border(bottom: BorderSide(color: Colors.grey)),
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.03),
                child: IconButton(
                    onPressed: () {},
                    icon: Image.asset("assets/logo_noteit.png")),
              ),
              const Spacer(),
              // IconButton(
              // IconButton(
              //   onPressed: () {
              //     // showSearch(context: context, delegate: Searchbar());
              //   },
              //   icon: const Icon(Icons.search),
              // ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.account_circle_outlined),
              ),
            ],
          ),
        ),
        body: 
        SafeArea(
            child: 
            Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1,right: screenWidth *0.2,left: screenWidth*0.2),
              child: Column(
                children: [
                  
                  const Text(
                    'How Much ?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        const Text(
                          '₹',
                          style: TextStyle(
                              fontSize: 45, fontWeight: FontWeight.w800),
                        ),
                        Expanded(
                          child: TextField(
                            // focusNode: FocusNode(),    
                            onTap: null,                  
                            // keyboardType: TextInputType.number,
                            controller: _amountController,
                            // enableInteractiveSelection: true,
                            decoration: const InputDecoration(
                              hintText: ' 0.00',
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
              padding: EdgeInsets.only(
                top: screenHeight * 0.1, 
                left: screenWidth * 0.1, 
                right: screenWidth * 0.1
                ),            
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
                      controller: _descriptionController,
                      enableInteractiveSelection: true,
                      minLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        
                      ),
                      decoration: const InputDecoration(
                        // hintText: 'Description',
                        prefixIcon: Icon(Icons.description,
                        color: Colors.white,
                        ),
                        iconColor: Colors.white,
                        labelText: "  Description",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    TextField(
                      controller: _categoryController,
                      enableInteractiveSelection: true,
                      
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.category,
                        color: Colors.white
                        ,
                        ),
                        labelText: '  Category',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight*0.01,),
                    TextField(
                      controller: _dateController,
                      style:const TextStyle(
                        color: Colors.white,
                      ),
                      readOnly: true,
                      enableInteractiveSelection: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.date_range_outlined,
                          color: Colors.white,
                          ),
                        labelText: '  Date',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: (){
                        _selectDate();
                      },
                    ),
                  ],
                ),
              ), 
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1,left: screenWidth*0.1,right: screenWidth*0.1),
              child: Center(
                child: 
              ElevatedButton(   
                  onPressed: () {
                    print("Button pressed");
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
                  ),
                  
                  ),
                  
            ),
            ),
          ],         
        ),
        
        ),
        );
        
  }
  Future<void>_selectDate()async{
         DateTime? picked =await showDatePicker(
            context: context, 
            firstDate: DateTime(2020), 
            lastDate: DateTime.now(),
            );
            if(picked != null){
              setState(() {
                _dateController.text = picked.toString().split(" ")[0];
                });
            }
        }

}
