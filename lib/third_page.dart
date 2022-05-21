import 'package:flutter/material.dart';
import 'localdb.dart';
import 'main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyThirdPage extends StatefulWidget {
  const MyThirdPage({Key? key, required this.title, required this.stock}) : super(key: key);
  final String title;
  final stock;
  @override
  State<MyThirdPage> createState() => _MyThirdPageState();
}

class _MyThirdPageState extends State<MyThirdPage> {

  List<StockSocialData> chartData = [
  ];

  var stock_details = {};

  @override
  void initState() {
    super.initState();
    http.get(Uri.parse("https://alexxieprojectml.sunyu912.repl.co/get-stock-details/" + widget.stock['ticker']))
        .then((res) {
          stock_details = jsonDecode(res.body);
          print(stock_details);

          chartData = [];
          for(var data in stock_details['data']) {
            // { "Close": 2682.60009765625, "High": 2785.6650390625, "Low": 2665.77001953125, "Open": 2775.0, "date": "2022-02-12", "tweet_count": 1 }
            var datestr = data['date'].split("-");
            var ssdata = StockSocialData(
                DateTime.utc(int.parse(datestr[0]), int.parse(datestr[1]), int.parse(datestr[2])),
                data['Close'],
                data['tweet_count']);
            chartData.add(ssdata);
          }

          setState(() {

          });
        }).catchError((error) {
          print("Failed to get the details");
          print(error);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Details"),
        actions: [
          IconButton(
            icon: !LocalDB.existsInWatchList(widget.stock['ticker']) ?
              const Icon(Icons.favorite_border) : const Icon(Icons.favorite),
            tooltip: 'Add to Watchlist',
            onPressed: () {
              if (LocalDB.existsInWatchList(widget.stock['ticker'])) {
                LocalDB.removeFromWatchlist(widget.stock['name'], widget.stock['ticker']);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Removed from your watchlist.')));
              } else {
                LocalDB.addToWatchlist(widget.stock['name'], widget.stock['ticker']);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to your watchlist.')));
              }
              setState(() {

              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              margin: EdgeInsets.all(5),
              child: Text(
                widget.stock['name'],
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue[300]
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.all(2),
              child: Text(
                widget.stock['ticker'],
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue[400],
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                color: Colors.grey,
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  Text(
                      'Price',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                  ),

                  Container(
                    height: 230,
                    child: SfCartesianChart(
                        primaryXAxis: DateTimeAxis(),
                        series: <ChartSeries>[
                          // Renders line chart
                          LineSeries<StockSocialData, DateTime>(
                              dataSource: chartData,
                              xValueMapper: (StockSocialData sales, _) => sales.date,
                              yValueMapper: (StockSocialData sales, _) => sales.price,
                              color: Colors.blue,
                              markerSettings: MarkerSettings(
                                  shape: DataMarkerType.circle,
                                  isVisible: true
                              )
                          )
                        ]
                    ),
                  )
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  Text(
                    'Social Trend',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(
                    height: 230,
                    child: SfCartesianChart(
                        primaryXAxis: DateTimeAxis(),
                        series: <ChartSeries>[
                          // Renders line chart
                          LineSeries<StockSocialData, DateTime>(
                              dataSource: chartData,
                              xValueMapper: (StockSocialData sales, _) => sales.date,
                              yValueMapper: (StockSocialData sales, _) => sales.tCount,
                              color: Colors.orange,
                              markerSettings: MarkerSettings(
                                  shape: DataMarkerType.circle,
                                  isVisible: true
                              )
                          )
                        ]
                    ),
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                color: Colors.grey,
              ),
            ),

            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Prediction",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            Row(
              children: [

                Expanded(
                    child: Column(
                      children: [
                        Text("Next Day", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(stock_details['prediction1'].toString() + "%")
                      ],
                    )
                ),

                Expanded(
                    child: Column(
                      children: [
                        Text("Next 2 Days", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(stock_details['prediction2'].toString() + "%")
                      ],
                    )
                ),

                Expanded(
                    child: Column(
                      children: [
                        Text("Next 3 Days", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(stock_details['prediction3'].toString() + "%")
                      ],
                    )
                ),

              ],
            ),

            SizedBox(height: 20)

          ],
        ),
      ),
    );
  }
}

class StockSocialData {
  StockSocialData(this.date, this.price, this.tCount);
  final DateTime date;
  final double price;
  final int tCount;
}