import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:akillicuzdan/model/constant.dart';

class MongoDatabase {
  static Db? db;
  static DbCollection? collection;

  // Connect to the MongoDB database with SSL options
  static Future<void> connect() async {
    try {
      // SSL with allowInvalidCertificates option
      db = Db(MONGO_URL);
      await db!.open(secure: true); // Enabling secure SSL connection
      
      inspect(db);
      collection = db!.collection(COLLECTION_NAME);
      print("Veritabanına başarıyla bağlanıldı.");
    } catch (e) {
      print("Veritabanına bağlanma hatası: $e");
    }
  }

  // Fetch user from the database
  static Future<Map<String, dynamic>?> getUser(String email, String password) async {
    if (db == null || collection == null) {
      print("Veritabanına bağlanılmadı. Lütfen önce bağlantıyı kontrol edin.");
      return null;
    }

    try {
      var user = await collection!.findOne({
        "email": email,
        "password": password,
      });
      return user;
    } catch (e) {
      print("Kullanıcı getirme hatası: $e");
      return null;
    }
  }

  // Insert user into the database
  static Future<void> insertUser(String username, String email, String password) async {
    if (db == null || collection == null) {
      print("Veritabanına bağlanılmadı. Lütfen önce bağlantıyı kontrol edin.");
      return;
    }

    try {
      await collection!.insertOne({
        "username": username,
        "email": email,
        "password": password,
      });
      print("Kullanıcı başarıyla eklendi.");
    } catch (e) {
      print("Kullanıcı ekleme hatası: $e");
    }
  }
}

