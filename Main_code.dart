import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sliver App Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: _MyAppBar(
                expandedHeight: 200,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Stories :",
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    )
                  ]),
                  Container(
                    height: 2000,
                    color: const Color.fromARGB(255, 255, 243, 206),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyAppBar extends SliverPersistentHeaderDelegate {
  _MyAppBar({
    required this.expandedHeight,
  });

  final double expandedHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final appBarSize = expandedHeight - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft:
                proportion > 0 ? Radius.circular(16) : Radius.circular(0),
            bottomRight:
                proportion > 0 ? Radius.circular(16) : Radius.circular(0),
          ),
          child: Container(
            color: Colors.blue,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Sliver App Bar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -150, // Adjust this value to control the overlap
          left: 0,
          right: 0,
          child: Visibility(
            visible: proportion > 0, // Hide the widget when proportion is 0
            child: Container(
              height: 250,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Widget partially outside SliverAppBar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(_MyAppBar oldDelegate) {
    return expandedHeight != oldDelegate.expandedHeight;
  }
}
