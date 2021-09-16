import 'package:flutter/material.dart';
import 'package:my_accountant/google_sheets_api.dart';
import 'package:my_accountant/my_accountant_income.dart';
import 'package:my_accountant/my_accountant_expense.dart';
import 'package:my_accountant/my_accountant_settings.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyApp_home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Accountant Expense',
      home: MyAccountant_home(),
    );
  }
}

class MyAccountant_home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAccountant_home();
  }
}

class _MyAccountant_home extends State<MyAccountant_home> {

  DateTime selectedDate = DateTime.now();
  late int total_expenses = 0;
  late int total_income = 0;
  late int current_balance = 0;
  late List total_exp = [];
  late List total_inc = [];
  late List<ChartData> monthly_exp_chartdata=[];
  late List<ChartData> monthly_inc_chartdata=[];
  late List<ChartData> exp_pm_chartdata=[];
  late List<ChartData> inc_pm_chartdata=[];
  late List<ChartData> exp_cat_chartdata=[];
  late List<ChartData> inc_cat_chartdata=[];

  void get_total_exp() async {

    var exp;

    exp = await GoolgeSheetsAPI.get_total_exp_amount();

    for(int i=0; i<exp.length;i++){
      total_expenses = total_expenses + int.parse(exp[i]);
    }
  }

  void get_total_inc() async {

    var inc;

    inc = await GoolgeSheetsAPI.get_total_inc_amount();

    for(int i=0; i<inc.length;i++){
      total_income = total_income + int.parse(inc[i]);
    }
  }

  void build_monthly_exp_chart_data() async {
    
    var month;
    var total_amount;

    month = await GoolgeSheetsAPI.get_exp_month();
    total_amount = await GoolgeSheetsAPI.get_monthly_exp();

    for(int i=0; i<month.length; i++){

      monthly_exp_chartdata.add(ChartData(await month[i],int.parse(await total_amount[i])));
    }
  setState(() {});
}

void build_monthly_inc_chart_data() async {
    
    var month;
    var total_amount;

    month = await GoolgeSheetsAPI.get_inc_month();
    total_amount = await GoolgeSheetsAPI.get_monthly_inc();

    for(int i=0; i<month.length; i++){

      monthly_inc_chartdata.add(ChartData(await month[i],int.parse(await total_amount[i])));
    }
  setState(() {});
}

void build_exp_pm_chart_data() async {
    
    var pms;
    var total_amount;

    pms = await GoolgeSheetsAPI.get_exp_pm();
    total_amount = await GoolgeSheetsAPI.get_exp_pm_amount();

    for(int i=0; i<pms.length; i++){

      exp_pm_chartdata.add(ChartData(await pms[i],int.parse(await total_amount[i])));
    }
  setState(() {});
}

void build_inc_pm_chart_data() async {
    
    var pms;
    var total_amount;

    pms = await GoolgeSheetsAPI.get_inc_pm();
    total_amount = await GoolgeSheetsAPI.get_inc_pm_amount();

    for(int i=0; i<pms.length; i++){

      inc_pm_chartdata.add(ChartData(await pms[i],int.parse(await total_amount[i])));
    }
  setState(() {});
}

void build_exp_cat_chart_data() async {
    
    var cat;
    var total_amount;

    cat = await GoolgeSheetsAPI.get_exp_cat();
    total_amount = await GoolgeSheetsAPI.get_exp_cat_amount();

    for(int i=0; i<cat.length; i++){

      exp_cat_chartdata.add(ChartData(await cat[i],int.parse(await total_amount[i])));
    }
  setState(() {});
}

void build_inc_cat_chart_data() async {
    
    var cat;
    var total_amount;

    cat = await GoolgeSheetsAPI.get_inc_cat();
    total_amount = await GoolgeSheetsAPI.get_inc_cat_amount();

    for(int i=0; i<cat.length; i++){

      inc_cat_chartdata.add(ChartData(await cat[i],int.parse(await total_amount[i])));
    }
  setState(() {});
}



  @override
  void initState(){

    super.initState();

    get_total_exp();
    get_total_inc();
    build_monthly_exp_chart_data();
    build_monthly_inc_chart_data();
    build_exp_pm_chart_data();
    build_inc_pm_chart_data();
    build_exp_cat_chart_data();
    build_inc_cat_chart_data();
}

  Widget navbar(BuildContext context){
    return Drawer(
    child: Container(
      padding: EdgeInsets.all(50),
      child: Column(
          children: [
              TextButton(
                  onPressed: (){},
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

  Widget monthly_exp_chart(BuildContext context){
  return Expanded(child: SfCircularChart(
    title: ChartTitle(text:"Monthly Expenses"),
    legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <CircularSeries>[
    PieSeries<ChartData, String>(
      dataSource: monthly_exp_chartdata,
      xValueMapper: (ChartData data,_) => data.measure,
      yValueMapper: (ChartData data,_) => data.amount,
      //dataLabelSettings: DataLabelSettings(isVisible: true),
      enableTooltip: true
    )
  ])
  );
}

  Widget monthly_inc_chart(BuildContext context){
  return Expanded(child: SfCircularChart(
    title: ChartTitle(text:"Monthly Income"),
    legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <CircularSeries>[
    DoughnutSeries<ChartData, String>(
      dataSource: monthly_inc_chartdata,
      xValueMapper: (ChartData data,_) => data.measure,
      yValueMapper: (ChartData data,_) => data.amount,
      //dataLabelSettings: DataLabelSettings(isVisible: true),
      enableTooltip: true
    )
  ])
  );
}

  Widget exp_pm_chart(BuildContext context){
  return Expanded(child: SfCircularChart(
    title: ChartTitle(text:"Expenses By Payment Method "),
    legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <CircularSeries>[
    PieSeries<ChartData, String>(
      dataSource: exp_pm_chartdata,
      xValueMapper: (ChartData data,_) => data.measure,
      yValueMapper: (ChartData data,_) => data.amount,
      //dataLabelSettings: DataLabelSettings(isVisible: true),
      enableTooltip: true
    )
  ])
  );
}

  Widget inc_pm_chart(BuildContext context){
  return Expanded(child: SfCircularChart(
    title: ChartTitle(text:"Income By Payment Method"),
    legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <CircularSeries>[
    DoughnutSeries<ChartData, String>(
      dataSource: inc_pm_chartdata,
      xValueMapper: (ChartData data,_) => data.measure,
      yValueMapper: (ChartData data,_) => data.amount,
      //dataLabelSettings: DataLabelSettings(isVisible: true),
      enableTooltip: true
    )
  ])
  );
}

  Widget exp_cat_chart(BuildContext context){
  return Expanded(child: SfCircularChart(
    title: ChartTitle(text:"Expenses By Category"),
    legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <CircularSeries>[
    PieSeries<ChartData, String>(
      dataSource: exp_cat_chartdata,
      xValueMapper: (ChartData data,_) => data.measure,
      yValueMapper: (ChartData data,_) => data.amount,
      //dataLabelSettings: DataLabelSettings(isVisible: true),
      enableTooltip: true
    )
  ])
  );
}

  Widget inc_cat_chart(BuildContext context){
  return Expanded(child: SfCircularChart(
    title: ChartTitle(text:"Income By Category"),
    legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <CircularSeries>[
    DoughnutSeries<ChartData, String>(
      dataSource: inc_cat_chartdata,
      xValueMapper: (ChartData data,_) => data.measure,
      yValueMapper: (ChartData data,_) => data.amount,
      //dataLabelSettings: DataLabelSettings(isVisible: true),
      enableTooltip: true
    )
  ])
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar(context),
      appBar: AppBar(
        title: Text("Home"), backgroundColor: Colors.blueAccent),
        body: Container(
          child: Center(
            child: ListView(
              children: [
                Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent)),
                child:Column(children: [
                total_income==0||total_expenses==0?Text("Loading....!"):Text("Total_Income: "+((total_income).toString()),
                style: TextStyle(
                  fontSize: 15,fontWeight: FontWeight.bold),),

                Padding(padding: EdgeInsets.all(5)),

                total_expenses==0?Text("Loading....!"):Text("Current_Expenses: "+(total_expenses.toString()),style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold),),

                Padding(padding: EdgeInsets.all(5)),

                total_income==0||total_expenses==0?Text("Loading....!"):Text("Current_Balance: "+((total_income-total_expenses).toString()),
                style: TextStyle(
                  fontSize: 15,fontWeight: FontWeight.bold),)


                ])
                ),
                Row(children: [
                monthly_exp_chartdata.isEmpty?Text("Loading....!"):monthly_exp_chart(context),
                Padding(padding: EdgeInsets.all(10)),
                monthly_exp_chartdata.isEmpty?Text("Loading....!"):monthly_inc_chart(context),
                ]),
                Padding(padding: EdgeInsets.all(20)),
                Row(children: [
                monthly_exp_chartdata.isEmpty?Text("Loading....!"):exp_pm_chart(context),
                Padding(padding: EdgeInsets.all(10)),
                monthly_exp_chartdata.isEmpty?Text("Loading....!"):inc_pm_chart(context),
                ]),
                Padding(padding: EdgeInsets.all(20)),
                Row(children: [
                monthly_exp_chartdata.isEmpty?Text("Loading....!"):exp_cat_chart(context),
                Padding(padding: EdgeInsets.all(10)),
                monthly_exp_chartdata.isEmpty?Text("Loading....!"):inc_cat_chart(context),
                ]),
              ]
            )
          )
        )
    );
  }
}

class ChartData{
  final String measure;
  final int amount;
  ChartData(this.measure,this.amount);
}