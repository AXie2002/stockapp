import 'package:flutter/material.dart';
//import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stockapp/localdb.dart';
import 'third_page.dart';

class MySecondPage extends StatefulWidget {
  const MySecondPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  var stock_list = [];
  var stock_list_trending = [];

  @override
  void initState() {
    super.initState();
    stock_list =
        LocalDB.all_stocks_trending; // initialize the stock list in the search bar
    stock_list_trending = LocalDB.all_stocks_trending;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Icon(
                  Icons.trending_up,
                  color: Colors.blue,
                ),
                Text(
                  "Trending Now",
                  style: TextStyle(fontSize: 22, color: Colors.blue),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: stock_list_trending.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Container(
                            height: 40,
                            // color: Colors.amber[500],
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '${stock_list_trending[index]['name']} (${stock_list_trending[index]['ticker']})',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                )),
                                Container(
                                  margin: EdgeInsets.only(right: 7),
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.blue,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                            print(
                                "onTap! " + stock_list_trending[index]['name']);
                            // go to third_page
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyThirdPage(
                                      title: 'Home Page',
                                      stock: stock_list_trending[index])),
                            );
                            setState(() {

                            });
                          },
                        ),
                      );
                    },
                    // separatorBuilder: (BuildContext context, int index) => const Divider(),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Icon(
                  Icons.my_location,
                  color: Colors.blue,
                ),
                Text(
                  "My Watchlist",
                  style: TextStyle(fontSize: 22, color: Colors.blue),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: LocalDB.stocks_watchlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Container(
                            height: 40,
                            // color: Colors.amber[500],
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '${LocalDB.stocks_watchlist[index]['name']} (${LocalDB.stocks_watchlist[index]['ticker']})',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                )),
                                Container(
                                  margin: EdgeInsets.only(right: 7),
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.blue,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                            print(
                                "onTap! " + LocalDB.stocks_watchlist[index]['name'].toString());
                            // go to third_page
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyThirdPage(
                                      title: 'Home Page',
                                      stock: LocalDB.stocks_watchlist[index])),
                            );
                            setState(() {

                            });
                          },
                        ),
                      );
                    },
                    // separatorBuilder: (BuildContext context, int index) => const Divider(),
                  ),
                ),
              ],
            ),
          ),
          //buildFloatingSearchBar(),
        ],
      ),
    );
  }

  // Widget buildFloatingSearchBar() {
  //   final isPortrait =
  //       MediaQuery.of(context).orientation == Orientation.portrait;

  //   return FloatingSearchBar(
  //     hint: 'Search Stock Ticker ...',
  //     scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
  //     transitionDuration: const Duration(milliseconds: 800),
  //     transitionCurve: Curves.easeInOut,
  //     physics: const BouncingScrollPhysics(),
  //     axisAlignment: isPortrait ? 0.0 : -1.0,
  //     openAxisAlignment: 0.0,
  //     width: isPortrait ? 600 : 500,
  //     height: 60,
  //     debounceDelay: const Duration(milliseconds: 500),
  //     onQueryChanged: (query) {
  //       // Call your model, bloc, controller here.
  //       print("Query changed: " + query);
  //
  //       var new_list = [];
  //       for (var item in LocalDB.all_stocks) {
  //         if (item['name']!.toLowerCase().contains(query.toLowerCase()) ||
  //             item['ticker']!.toLowerCase().contains(query.toLowerCase())) {
  //           new_list.add(item);
  //           if (new_list.length > 20) {
  //             break;
  //           }
  //         }
  //       }
  //       print("Result size: " + new_list.length.toString());
  //       stock_list = new_list;
  //
  //       setState(() {});
  //     },
  //     // Specify a custom transition to be used for
  //     // animating between opened and closed stated.
  //     transition: CircularFloatingSearchBarTransition(),
  //     actions: [
  //       FloatingSearchBarAction(
  //         showIfOpened: false,
  //         child: CircularButton(
  //           icon: const Icon(Icons.show_chart),
  //           onPressed: () {},
  //         ),
  //       ),
  //       FloatingSearchBarAction.searchToClear(
  //         showIfClosed: false,
  //       ),
  //     ],
  //     builder: (context, transition) {
  //       return ClipRRect(
  //         borderRadius: BorderRadius.circular(8),
  //         child: Material(
  //           color: Colors.white,
  //           elevation: 4.0,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: stock_list.map((stock) {
  //               return Card(
  //                 child: ListTile(
  //                     onTap: () async {
  //                       print("onTap! " + stock['name']);
  //                       // go to third_page
  //                       await Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) =>
  //                                 MyThirdPage(title: 'Home Page', stock: stock)),
  //                       );
  //                       setState(() {
  //
  //                       });
  //                     },
  //                     title: Container(
  //                       height: 60,
  //                       width: double.infinity,
  //                       margin: EdgeInsets.only(left: 0),
  //                       // color: Colors.blue,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(stock['name'].toString(), style: TextStyle(fontWeight: FontWeight.bold),),
  //                           Text(stock['ticker'].toString(), style: TextStyle(color: Colors.grey))
  //                         ],
  //                       ),
  //                     )),
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
