import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.bookmark),
              style: ButtonStyle(
                iconColor:
                    WidgetStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
          )
        ],
        title: Text(
          "Detail",
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 24),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios),
            style: ButtonStyle(
              iconColor:
                  WidgetStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 500),
                child: 
                  Image.asset(
                    "assets/images/bg.png",
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),),
                  Positioned(
                    bottom: -20,
                    left: 30,
                    child: Row(
                      children: [
                        Image.asset("assets/images/spider-man.png"),
                        Text("Spiderman No Way Home"),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
