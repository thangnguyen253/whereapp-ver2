import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/resources/search_page.dart';

class RidePicker extends StatefulWidget {
  @override
  _RidePickerState createState() => _RidePickerState();
}

class _RidePickerState extends State<RidePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0x88999999),
              offset: Offset(0, 5),
              blurRadius: 5.0,
            ),
          ]),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 20,
                      child: Center(child: Image.asset("pin.png")),
                    ),
                    // Positioned(
                    //   right: 0,
                    //   top: 0,
                    //   width: 40,
                    //   height: 50,
                    //   child: Center(child: Image.asset(name),),
                    // )
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: Text(
                        "To dan pho Tan, thi tran Kep, Lang Giang, Bac Giang",
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff323643)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () {},
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 20,
                      child: Center(child: Image.asset("arrow.png")),
                    ),
                    // Positioned(
                    //   right: 0,
                    //   top: 0,
                    //   width: 40,
                    //   height: 50,
                    //   child: Center(child: Image.asset(name),),
                    // )
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: Text(
                        "Home",
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff323643)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
