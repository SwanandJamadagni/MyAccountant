import 'package:flutter/material.dart';
import 'package:my_accountant/google_sheets_api.dart';
import 'package:my_accountant/my_accountant_home.dart';
import 'package:my_accountant/my_accountant_expense.dart';
import 'package:my_accountant/my_accountant_income.dart';

class MyApp_settings extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Accountant Expense',
      home: MyAccountant_settings(),
    );
  }
}

class MyAccountant_settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAccountant_settings();
  }
}

class _MyAccountant_settings extends State<MyAccountant_settings> {

  TextEditingController PMController = new TextEditingController();
  TextEditingController CatController = new TextEditingController();
  
  Widget navbar(BuildContext context){
    return Drawer(
    child: Container(
      padding: EdgeInsets.all(50),
      child: Column(
          children: [
              TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp_home())
                    );
                    
                  },
                  child: Text('Home')
              ),
              TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp_expense())
                    );

                  },
                  child: Text('Add_Expense')
              ),
              TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp_income())
                    );

                  },
                  child: Text('Add_Income')
              ),
              TextButton(
                  onPressed: (){},
                  child: Text('Add_Investment')
              ),
              TextButton(
                  onPressed: (){},
                  child: Text('Settings')
              )
          ]
        )
    )
    );
  }

  Widget expenseInput(BuildContext context){
    return Column(
              children: [
                TextField(
                  controller: PMController,
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextButton(
                  onPressed: () async {
                    try{
                      final pm = {
                        'Payment Methods': PMController.text,
                      };
                      await GoolgeSheetsAPI.insert_pm([pm]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Payment Method Added Succesfully....!"),
                      ));
                      PMController.clear();
                    }
                    catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Error Occured....!"),
                     ));
                      PMController.clear();
                    }
                  },
                  child: Text('Add Payment Method')
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                  controller: CatController,
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextButton(
                  onPressed: () async {
                    try{
                      final cat = {
                      'Categories': CatController.text,
                    };
                     await GoolgeSheetsAPI.insert_cat([cat]);
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Category Added Succesfully....!"),
                      ));
                      CatController.clear();
                  }
                  catch(e){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Error Occured....!"),
                     ));
                     CatController.clear();
                  }
                  },
                  child: Text('Add Category')
                )
              ]
            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar(context),
      appBar: AppBar(
        title: Text("Settings"), backgroundColor: Colors.blueAccent),
        body: Container(
          padding: EdgeInsets.all(50),
          child: Center(
            child: expenseInput(context)
        )
      ),
    );
  }
}