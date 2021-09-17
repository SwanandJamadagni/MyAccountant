import 'package:gsheets/gsheets.dart';
import 'my_accountant_income.dart';

class GoolgeSheetsAPI {
  static const _credentials = r'''
  {
Json_Key
}
''';

  static final _spreadsheetID = google_sheets_id;
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _exp_worksheet,_inc_worksheet,_pm_worksheet,_cat_worksheet,_exp_pm_worksheet,_exp_cat_worksheet,_income_pm_worksheet,_income_cat_worksheet,_monthly_exp_worksheet,_monthly_inc_worksheet;

  static Future init() async {
    try{
    final spreadsheet = await _gsheets.spreadsheet(_spreadsheetID);
    _exp_worksheet = await _getWorksheet(spreadsheet, title:'Expense');
    _inc_worksheet = await _getWorksheet(spreadsheet, title:'Income');
    _pm_worksheet = await _getWorksheet(spreadsheet, title:'Payment Methods');
    _cat_worksheet = await _getWorksheet(spreadsheet, title:'Categories');

    _exp_pm_worksheet = await _getWorksheet(spreadsheet, title:'Exp_PM');
    _exp_cat_worksheet = await _getWorksheet(spreadsheet, title:'Exp_Cat');
    _income_pm_worksheet = await _getWorksheet(spreadsheet, title:'Income_PM');
    _income_cat_worksheet = await _getWorksheet(spreadsheet, title:'Income_Cat');

    _monthly_exp_worksheet = await _getWorksheet(spreadsheet, title:'Monthly_Expense');
    _monthly_inc_worksheet = await _getWorksheet(spreadsheet, title:'Monthly_Income');

    _exp_worksheet!.values.insertRow(1, ['Date','Amount','Payment Method','Category','Description']);
    _inc_worksheet!.values.insertRow(1, ['Date','Amount','Payment Method','Category','Description']);
    _pm_worksheet!.values.insertRow(1, ['Payment Methods']);
    _cat_worksheet!.values.insertRow(1, ['Categories']);
    }
    catch(e){
      print("Init Error: $e");
    }

  }

  static Future<Worksheet> _getWorksheet(
    Spreadsheet spreadsheet, {
      required String title,
      }) async {
        try{
          return await spreadsheet.addWorksheet(title);
        }
        catch(e){
          return spreadsheet.worksheetByTitle(title)!;
        }
      }

    static Future insert_pm(List<Map<String, dynamic>> pmrow) async{
      _pm_worksheet!.values.map.appendRows(pmrow);
    }

    static Future insert_cat(List<Map<String, dynamic>> catrow) async{
      _cat_worksheet!.values.map.appendRows(catrow);
    }

    static Future insert_income(List<Map<String, dynamic>> incomerow) async{
      _inc_worksheet!.values.map.appendRows(incomerow);
    }

    static Future insert_expense(List<Map<String, dynamic>> expenserow) async{
      _exp_worksheet!.values.map.appendRows(expenserow);
    }

    static get_pm() async {
     var pms =  _pm_worksheet!.values.columnByKey("Payment Methods");
      return await pms;
    }

    static get_cat() async {
     var catrgories =  _cat_worksheet!.values.columnByKey("Categories");
      return await catrgories;
    }

    static get_total_exp_amount() async {
     var amount =  _exp_worksheet!.values.columnByKey("Amount");
      return await amount;
    }

    static get_total_inc_amount() async {
     var amount =  _inc_worksheet!.values.columnByKey("Amount");
      return await amount;
    }

    static get_exp_pm() async {
     var exp_pm =  await _exp_pm_worksheet!.values.columnByKey("Payment_Method");
     return await exp_pm;
    }

    static get_exp_pm_amount() async {
      var total_amount = await _exp_pm_worksheet!.values.columnByKey("Total_Amount");
      return await total_amount;
    }

        static get_exp_cat() async {
     var exp_cat =  await _exp_cat_worksheet!.values.columnByKey("Category");
     return await exp_cat;
    }

    static get_exp_cat_amount() async {
      var total_amount = await _exp_cat_worksheet!.values.columnByKey("Total_Amount");
      return await total_amount;
    }

        static get_inc_pm() async {
     var inc_pm =  await _income_pm_worksheet!.values.columnByKey("Payment_Method");
     return await inc_pm;
    }

    static get_inc_pm_amount() async {
      var total_amount = await _income_pm_worksheet!.values.columnByKey("Total_Amount");
      return await total_amount;
    }

    static get_inc_cat() async {
     var inc_cat =  await _income_cat_worksheet!.values.columnByKey("Category");
     return await inc_cat;
    }

    static get_inc_cat_amount() async {
      var total_amount = await _income_cat_worksheet!.values.columnByKey("Total_Amount");
      return await total_amount;
    }

    static get_exp_month() async {
     var month =  await _monthly_exp_worksheet!.values.columnByKey("Month");
     return await month;
    }

    static get_monthly_exp() async {
     var total_amount =  await _monthly_exp_worksheet!.values.columnByKey("Total_Amount");
     return await total_amount;
    }

    static get_inc_month() async {
     var month =  await _monthly_inc_worksheet!.values.columnByKey("Month");
     return await month;
    }

    static get_monthly_inc() async {
     var total_amount =  await _monthly_inc_worksheet!.values.columnByKey("Total_Amount");
     return await total_amount;
    }
}
