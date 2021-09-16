import 'package:flutter/material.dart';
import 'package:my_accountant/google_sheets_api.dart';
import 'package:my_accountant/my_accountant_home.dart';
import 'package:my_accountant/my_accountant_income.dart';
import 'package:my_accountant/my_accountant_settings.dart';

class MyApp_expense extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Accountant Expense',
      home: MyAccountant_expense(),
    );
  }
}

class MyAccountant_expense extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAccountant_expense();
  }
}

class _MyAccountant_expense extends State<MyAccountant_expense> {
  
  DateTime selectedDate = DateTime.now();
  final List<String> pm = [];
  final List<String> cat = [];
  String ?chosenpm;
  String ?chosencat;
  TextEditingController AmountController = new TextEditingController();
  TextEditingController DescController = new TextEditingController();

    Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

void get_pm() async {
  var pms;
  pms = await GoolgeSheetsAPI.get_pm();
  for(int i=0; i<pms.length; i++){
    pm.add(await pms[i]);
  }
  setState(() {});
}

void get_cat() async {
  var categories;
  categories = await GoolgeSheetsAPI.get_cat();
  for(int i=0; i<categories.length; i++){
    cat.add(await categories[i]);
  }
  setState(() {});
}
  

  @override
  void initState(){

    super.initState();
    get_pm();
    get_cat();
}

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
                  onPressed: (){},
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
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp_settings())
                    );

                  },
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
              TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select date')
              ),

              Padding(padding: EdgeInsets.all(10)),

              Text("${selectedDate.toLocal()}".split(' ')[0]),
              Padding(padding: EdgeInsets.all(10)),
              TextField(
                controller: AmountController,
                decoration: InputDecoration(
                hintText: 'Amount'
                ),
                keyboardType: TextInputType.number,
                ),

                Padding(padding: EdgeInsets.all(10)),

                Container(
                  child: DropdownButton<String>(
                      value: chosenpm,
                      style: TextStyle(color: Colors.blueAccent),
                      items: pm.map((value) {
                        return DropdownMenuItem<String>(
                        value: value,
                        child: Container( 
                          height: 50,
                          width: 150,
                        child: Text(value),
                        )
                      );
                      }).toList(),
                      hint: Text(
                      "Payment Method",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        chosenpm = value!;
                      });
                    }
                  )
                ),

               Padding(padding: EdgeInsets.all(10)),

               Container(
                  child: DropdownButton<String>(
                      value: chosencat,
                      style: TextStyle(color: Colors.blueAccent),
                      items: cat.map((value) {
                        return DropdownMenuItem<String>(
                        value: value,
                        child: Container( 
                          height: 50,
                          width: 150,
                        child: Text(value),
                        )
                      );
                      }).toList(),
                      hint: Text(
                      "Category",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        chosencat = value!;
                      });
                    }
                  )
                ),

                Padding(padding: EdgeInsets.all(10)),

                TextField(
                  controller: DescController,
                  decoration: InputDecoration(
                  hintText: 'Description'
                  )
                ),
                
                Padding(padding: EdgeInsets.all(10)),
                
                TextButton(
                  onPressed: ()async{
                    try{
                      final expense = {

                        'Date': selectedDate.toString(),
                        'Amount': AmountController.text,
                        'Payment Method': chosenpm,
                        'Category': chosencat,
                        'Description': DescController.text
                      };
                      if(chosenpm == null || chosencat == null || AmountController.text == '' || DescController.text == ''){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("All fields are required...!"),
                      ));
                      }
                      else{
                        try{
                          await GoolgeSheetsAPI.insert_expense([expense]);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Expense Added Successfully...!"),
                        ));
                        }
                        catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Error While Adding Expense..!"),
                          ));
                        }
                        
                      }
                    }
                    catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Error..!"),
                      ));
                    }
                  },
                  child: Text('Add')
              )
              ]
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar(context),
      appBar: AppBar(
        title: Text("Expense"), backgroundColor: Colors.blueAccent),
        body: Container(
          padding: EdgeInsets.all(50),
          child: Center(
            child: expenseInput(context)
        )
      ),
    );
  }
}