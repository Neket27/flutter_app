import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/home/carousel/carouselRecentPeople.dart';
import 'package:project_app/people/messageWithPeoples.dart';
import 'package:project_app/menuLeft/panelMenu.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) :super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _globalKeyMenuPerson = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var _scaffoldKey;
    return  Scaffold(
      body:MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color.fromRGBO(254,240,220,10),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title:Text('Massage proger'),
            centerTitle: true,
            backgroundColor: Colors.deepPurpleAccent,
            toolbarHeight: 25,
          ),
          key: _globalKeyMenuPerson,
          drawer: PanelMenu(),

          body: SafeArea(
            child: Padding(padding: EdgeInsets.all(20),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(onTap: ()=> _globalKeyMenuPerson.currentState!.openDrawer(),child: Icon(Icons.arrow_back_ios),),
                      //  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new_rounded),),
                      Text('Недавно писавшие люди', ),
                      IconButton(onPressed: (){}, icon: Icon(Icons.search_rounded,size: 30,)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      Container(
                        width: 320, //изменить на авто ширину !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        height: 250,
                        decoration: BoxDecoration(color: Colors.white,),
                        child: CarouselRecentPeople(),

                      ),
                    ],
                  ),
                  Column(
                     mainAxisSize: MainAxisSize.min,
                    verticalDirection: VerticalDirection.down,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Padding(padding: EdgeInsets.only(top: 260,),
                        child: ElevatedButton(
                            onPressed: (){_screenMassege(context);},
                            style: ButtonStyle(

                              backgroundColor: MaterialStateProperty.all(Colors.black),
                              fixedSize: MaterialStateProperty.all(const Size(200, 40)),
                            ) ,child: Text('Переписки')
                        ),
                      ),

                    ],
                  ),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }

  void _screenMassege(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MessageWithPeople()));
  }

}

