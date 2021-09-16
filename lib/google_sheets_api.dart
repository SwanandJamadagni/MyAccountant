import 'package:gsheets/gsheets.dart';
import 'my_accountant_income.dart';

class GoolgeSheetsAPI {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "myaccountant-11196",
  "private_key_id": "ddb0f4101048da384f74066c163d358afd775cef",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCiF6feKfIx6tk4\nNV+vhsl0lTFKJRyjF/GMaEqECz1lDMWhxpBKa5gQJ5vyWu/Ux0pLwrycycsw31zu\nbn+7SyVo6vI9FGrKtyt6Q0mWd1svMguaTkOFkMY7eIEdWw+DoEeFtXLNZqvyuObW\npcG5faqc6CUjxoMgel4NLt5pO2zKkgPYBnCvJa1YueFvgRirUE4eOfKmsidGegZN\njuZL2Le0tXRlVApic7dYVToAJrk3O2eTJ391SCWPCPzTGlJhMDgpq858QG8k0ZUh\n74bHK6FN/glaa7b29O13Yq+7yTMTZ+pHa0nTwLEs2r/1DfOYcAuWZBH79Eds3ezW\nXPO+zM6bAgMBAAECggEAJJUgLtTas4dkZPou0UejWet+B1Te5LQ3sM+s2aZLwe2j\nAQL2d8VWuXanDIiXjjc4PmcB+ITWlf4jVDCeJWAtXkOATma4P24doudiyVHAw6MQ\n2U+Gj7N/+dYVldGCa9uVqMit00uzzQEMIC+izEFfazA9iZh46bCUX3dPfQKLaCA2\nJqsIf3XGXKvcdNHVKipGrxBd/yC42IAEKJrxJEITIu3ZAVk+vnTctRKsgFilcdRH\nIQDlz4D0e7cCDtlBn/J2Zo4JZbx/EVxg3hNmESBPqXpl44+FXGUNcMQ0MeIOSIHu\nXJd4G8l/QF08z87/JEmZ08BEdsomt9B/p2hmxQd+8QKBgQDW+pfBwqngwuMQmxLF\nmQT50WCDJco6eDPN5w1YfT87ePePOIthE/2NupDVFO7uzDPN1s/t+yoD0YjpK5rT\n23yGUpU3Dbx7O0xakwxrkmuX1mpZhv7s6XUDWCvnCRfE45A3dc+sEkNbab7wx1iW\nfBd5my5XMxkFC710+0gYJ/l3yQKBgQDBBaKfBtJFqcGuQRoNkDN25IRU+rko5QlW\nWXi2ydp8lFc+YEUwhTaJQqtkS5605W93Kshms9N3UNnApgENaYGH1XQoj8zbUfuT\nX8DaBAWnF9Q4qYhuZFfZi064q2KFa+oQest10n4haIuvGzodlgqu3KjxrxvuCfpq\n4GTeZyNNQwKBgQC1D5gTND3ZtKqDiOhVjlx3f5X2vzRE7IpNKAXAerRwBaETej9B\nwxFxdimXnarjaw9SlVLJEBpB3w+duwEK4DhP9WwBU0tkyvuy6ViznT2LQ6aMwrsg\nlDveVjububfQNw12+H2xYixi6HxN1MfS7q7i2AU+oiW3bzzhMuZ0me5tqQKBgAIw\nNSrGYgXmKcr28/upYdv8NT/dY9IB3rw64XJ5EWAOMnsDjmVBbV/bAKRvcwor+7qH\nIqR/b2tP4Fgdya9EPfKzSdDX6IOoB0khccdG+mVtkLtfuKs/ufs+aBMR5lkK4yly\nqvHYBBQO4l6G2X7SX6ah28x5psBpHoytpJcc5jqPAoGBAIf2J65hkJG0kOVotDvF\nWlwYXwd4lozzK0VFGDcvYL11iLl0T2Ymy6RP/8g9W8ASLlHm8r75rgkA2n7cr9fK\nMjFcOPeOLJ0QwrFAco9yU7W3a5uzJHWkQb+n4kh9sm23zXBvtDXO3y3Bl1IEYti6\njx1tzlSHZsDcUgJJHox9l706\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-fvs3e@myaccountant-11196.iam.gserviceaccount.com",
  "client_id": "115987223111253530411",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fvs3e%40myaccountant-11196.iam.gserviceaccount.com"
}
''';

  static final _spreadsheetID = '10dOn0ytSQYM-gquCyGjf9IhikPqhsWF68fvCVEdhm2k';
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