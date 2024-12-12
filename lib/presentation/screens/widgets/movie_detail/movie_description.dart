import 'package:flutter/material.dart';

class MovieDescription extends StatelessWidget {
  const MovieDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 29, vertical: 24),
      child: Text(
        "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }
}
