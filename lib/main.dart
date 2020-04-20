import 'package:flutter/material.dart';
import 'package:flightlist/CustomShapeClipper.dart';
import 'package:intl/intl.dart';

import 'CustomAppBar.dart';

void main() => runApp(MaterialApp(
  title:'Flight List',
  debugShowCheckedModeBanner: false,
  home:HomeScreen(),
  theme: appTheme,
  ));

Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);

List<String> locations = ['Boston (BOS)', 'New York (JFK)'];

TextStyle dropdownLabelStyle = TextStyle(color:Colors.white, fontSize: 16.0); 
TextStyle dropdownMenuItemStyle = TextStyle(color:Colors.black, fontSize: 16.0); 

ThemeData appTheme =
    ThemeData(primaryColor: Color(0xFFF3791A), fontFamily: 'Oxygen');

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: CustomAppBar(),
      body:Column(
        children: <Widget>[
          HomeScreenTopPart(),
          homeScreenbottom
        ],
      )
    );
  }
} 

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  var selectedLocationindex = 0;
  bool isFlightSelected =true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(clipper:CustomShapeClipper(),
        child:Container(height:400.0, decoration:BoxDecoration(gradient:LinearGradient(colors:[
          firstColor,
          secondColor
        ],),),
        child: Column(
          children:<Widget>[
            SizedBox(height:50.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children:<Widget> [
                  Icon(Icons.location_on, color:Colors.white),
                  SizedBox(width: 16.0,),
                  PopupMenuButton(
                    onSelected: (index){
                          setState(() {
                            selectedLocationindex = index;
                          });
                    },
                    child: Row(
                    children:<Widget>[
                      Text(locations[selectedLocationindex],
                       style: dropdownLabelStyle, ),
                      Icon(Icons.keyboard_arrow_down, color:Colors.white),
                    ]
                  ),
                  itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                    PopupMenuItem(
                      child:Text(locations[0],style:dropdownMenuItemStyle),value: 0 
                    ,),
                    PopupMenuItem(
                      child:Text(locations[1],style:dropdownMenuItemStyle),value: 1 
                    ,)
                  ]),
                  Spacer(),
                Icon(Icons.settings, color: Colors.white)
              ],),
            ),
            SizedBox(height:50.0),
            Text('Where Would\n you want to go', style: TextStyle(fontSize:24.0,color: Colors.white),textAlign: TextAlign.center,),
            SizedBox(height:30.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:32.0),
               child: Material(
                 elevation: 5.0,
                 borderRadius: BorderRadius.all(Radius.circular(30.0)),
                 child: TextField(
                   controller:TextEditingController(text:locations[0]),
                   style: dropdownMenuItemStyle,
                   cursorColor: appTheme.primaryColor,
                   decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(horizontal:32.0, vertical: 14.0),
                     suffixIcon: Material(
                       elevation:2.0,
                       borderRadius:BorderRadius.all(Radius.circular(30.0)),
                       child:Icon(Icons.search)
                     ),
                     border:InputBorder.none
                   ),
                 ),
               ),),
                SizedBox(
                  height: 20.0,
                ),
               Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children:[
                   InkWell(
                     child:
                   ChoiseChip(Icons.flight_takeoff,"flights",isFlightSelected),
                   onTap: (){
                     setState((){
                        isFlightSelected =true;
                     });
                   },
                   ),
                   SizedBox(width:20.0),
                   InkWell(
                     child:
                      ChoiseChip(Icons.hotel,"Hotels",!isFlightSelected),
                      onTap: (){setState(() {
                             isFlightSelected =false;    
                                            });
                      }
                   )
                   
                 ]
               )
          ]
        ),),)
      ],      
    );
  }
}


class ChoiseChip extends StatefulWidget {

  final IconData icon;
  final String text;
  final bool isSelected;

  ChoiseChip(this.icon,this.text ,this.isSelected);
  @override
  _ChoiseChipState createState() => _ChoiseChipState();
}

class _ChoiseChipState extends State<ChoiseChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:10.0, vertical: 5.0),
      decoration: widget.isSelected ?
       BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.all(Radius.circular(20.0),)
      )
      : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Icon(widget.icon,
             size: 20.0,
            color: Colors.white,),
            SizedBox(width:8.0),
        Text(widget.text,
         style: TextStyle(color:Colors.white, fontSize: 16.0),)
      ]),
    );
    
  }
}




var homeScreenbottom = Column(
  children:[
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children:[
          Text("Currently Watched item",style:TextStyle(color:Colors.black, fontSize: 16.0)),
          Spacer(),
          Text("VIEW ALL(12)",style:TextStyle(color:appTheme.primaryColor, fontSize: 16.0))
        ]
      ),
    ),
    Container(
      height: 260.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:cityCards
      ),
    )
  ]
);

List<CityCard> cityCards = [
  CityCard(
      "assets/images/lasvegas.jpg", "Las Vegas", "Feb 2019", "45", 4299, 2250),
  CityCard("assets/images/athens.jpg", "Athens", "Apr 2019", "50", 9999, 4159),
  CityCard("assets/images/sydney.jpeg", "Sydney", "Dec 2018", "40", 5999, 2399)
];

final formatCurrency = new  NumberFormat.simpleCurrency();
class CityCard extends StatelessWidget {

  final String imagePath, cityName, monthYear , discount ;
  final int oldPrice, newPrice;
  CityCard(this.imagePath, this.cityName, this.monthYear , this.discount , this.oldPrice, this.newPrice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Stack(
              children: [
                Container(
                  height: 230.0,
                  width: 160.0,
                  child:Image.asset(imagePath, fit: BoxFit.cover,)),
                  Positioned(
                    left: 0.0,
                    bottom: 0.0,
                    right: 0.0,
                    height: 60.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient:LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors:[
                            Colors.black, Colors.black.withOpacity(0.1)
                          ]
                        )
                      ),
                    ),
                  ),
                  Positioned(
                    left:10.0,
                    bottom:10.0,
                    right:10.0,
                    child:Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                      Text(cityName,style:TextStyle(color:Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text(monthYear,style:TextStyle(color:Colors.white, fontSize: 12.0, fontWeight: FontWeight.normal)),
                        ]
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal:6.0 , vertical:2.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape:BoxShape.rectangle,
                          borderRadius:BorderRadius.all(Radius.circular(10.0))
                        ),
                        child: Text("$discount%",style:TextStyle(color:Colors.black, fontSize: 12.0, fontWeight: FontWeight.normal))),
                    ],)
                  )
              ],
            ),
          ),
          Row(
          mainAxisSize: MainAxisSize.max,  
          mainAxisAlignment: MainAxisAlignment.start,  
          children: [
          SizedBox(width:5.0),
          Text('${formatCurrency.format(newPrice)}',style:TextStyle(color:Colors.black, fontSize: 16.0, fontWeight: FontWeight.normal)),
           SizedBox(width:5.0),
          Text('${formatCurrency.format(oldPrice)}',style:TextStyle(color:Colors.grey, fontSize: 16.0, fontWeight: FontWeight.normal))
        ],)
        ],

      ),
    );
  }
}