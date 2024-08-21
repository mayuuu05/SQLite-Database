import 'package:get/get.dart';
import 'package:sqlite_database/helper/db_helper_service.dart';

class DatabaseController extends GetxController {
  var quotes = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    initDb();
  }

  Future<void> initDb() async {
    await DbHelper.dbHelper.database;
    loadQuotes();
  }

  Future<void> loadQuotes() async {
    final data = await DbHelper.dbHelper.getQuotes();
    quotes.assignAll(data);
  }

  Future<void> addQuote(String quote, String author, String category) async {
    await DbHelper.dbHelper.insertQuote(quote, author, category);
    loadQuotes();
  }
  Future<void> deleteQuote(int index) async {
    await DbHelper.dbHelper.deleteQuote(index);
    loadQuotes();
  }
}
