import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;


class LocalDB {

  static var prefs;

  static void initPrefs() async {
    prefs = await SharedPreferences.getInstance();

    var stockStrList = prefs.getStringList("watchList");
    if (stockStrList != null) {
      stocks_watchlist.clear();
      for(var stockStr in stockStrList) {
        var parts = stockStr.toString().split(":");
        stocks_watchlist.add({
          "name" : parts[0],
          "ticker" : parts[1],
        });
      }
    }
  }

  static void addToWatchlist(String name, String ticker) {
    stocks_watchlist.add({
      "name" : name,
      "ticker" : ticker
    });
    updateToPrefs();
  }

  static void removeFromWatchlist(String name, String ticker) {
    for(var stock in stocks_watchlist) {
      if (stock['ticker'] == ticker) {
        stocks_watchlist.remove(stock);
        break;
      }
    }
    updateToPrefs();
  }

  static void updateToPrefs() {
    print("update prefs");
    List<String> stockStrList = <String>[];
    for(var stock in stocks_watchlist) {
      stockStrList.add(stock['name'].toString() + ":" + stock['ticker'].toString());
    }
    print(stockStrList);
    prefs.setStringList("watchList", stockStrList);
  }

  static bool existsInWatchList(String ticker) {
    for(var stock in stocks_watchlist) {
      print("Compare: " + ticker + " <----> " + stock['ticker'].toString());
      if (stock['ticker'] == ticker) {
        print("In watchlist: true");
        return true;
      }
    }
    print("In watchlist: false");
    return false;
  }

  static Future<void> loadAllStocks() async {
    final _rawData = await rootBundle.loadString("assets/stockdb.csv");
    var lines = _rawData.split("\n");
    for(var line in lines) {
      var parts = line.split(",");
      all_stocks.add({
        "name" : parts[0].trim(),
        "ticker" : parts[1].trim()
      });
    }
    print("Getting final list: ");

  }

  static var stocks_watchlist = [
    {
      "name" : "Tesla",
      "ticker" : "TSLA"
    },
    {
      "name" : "Texas Instruments",
      "ticker" : "TXN"
    },
    {
      "name" : "NetFlix",
      "ticker" : "NFLX"
    },
    {
      "name" : "Amazon",
      "ticker" : "AMZN"
    },
  ];

  static var all_stocks = [
    // {
    //   "name" : "Tesla",
    //   "ticker" : "TSLA"
    // },
    // {
    //   "name" : "Texas Instruments",
    //   "ticker" : "TXN"
    // },
    // {
    //   "name" : "Marvell Technology",
    //   "ticker" : "MRVL"
    // },
    // {
    //   "name" : "NetFlix",
    //   "ticker" : "NFLX"
    // },
    // {
    //   "name" : "Amazon",
    //   "ticker" : "AMZN"
    // },
    // {
    //   "name" : "Google",
    //   "ticker" : "GOOG"
    // },
    // {
    //   "name" : "Apple",
    //   "ticker" : "APPL"
    // },
    // {
    //   "name" : "Facebook",
    //   "ticker" : "META"
    // },
  ];

  static var all_stocks_trending = [
    // {
    //   "name" : "Tesla",
    //   "ticker" : "TSLA"
    // },
    // {
    //   "name" : "Texas Instruments",
    //   "ticker" : "TXN"
    // },
    // {
    //   "name" : "Marvell Technology",
    //   "ticker" : "MRVL"
    // },
    // {
    //   "name" : "NetFlix",
    //   "ticker" : "NFLX"
    // },
    // {
    //   "name" : "Amazon",
    //   "ticker" : "AMZN"
    // },
    // {
    //   "name" : "Google",
    //   "ticker" : "GOOG"
    // },
    // {
    //   "name" : "Apple",
    //   "ticker" : "APPL"
    // },
    // {
    //   "name" : "Facebook",
    //   "ticker" : "META"
    // },
  ];
}