import 'package:flutter/material.dart';

class CarouselRecentPeople extends StatefulWidget {
  @override
  _CarrousselState createState() => new _CarrousselState();
}

class _CarrousselState extends State<CarouselRecentPeople> {
  late PageController controller;
  int currentpage = 0;

  @override
  initState() {
    super.initState();
    controller = PageController(
      initialPage: currentpage,
      keepPage: false,
      viewportFraction: 0.5,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color.fromRGBO(254,240,220,10),
          child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentpage = value;
                });
              },
              controller: controller,
              itemBuilder: (context, index) => builder(index)),
        ),
      ),
    );
  }

  builder(int index) {
    double val=1.0;
    //if(index<4)
    val = (controller.page! - index)!;
    val = (1 - (val.abs() * .5)).clamp(0.0, 1.0);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = (controller.page! - index)!;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
        }

        return Center(
          child: Container(
            height: Curves.easeOut.transform(value) * 280,
            width: Curves.easeOut.transform(value) * 150,
            child: child,
          ),
        );
      },
      child: Container(
          width: 150,
          height: 250,
        margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.white,),
          child: Padding(padding:EdgeInsets.all(20),
            child: Column(

              children: [
                // Padding(padding: EdgeInsets.only(top: 40,left: 40),),
                //Icon(Icons.face_retouching_natural, size: 100,),
                Text(index.toString()),
                CircleAvatar(backgroundImage: AssetImage('assets/I.jpg'), radius: 30,),
                SizedBox(height: 20,),
                Text('Name',style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
                  height: Curves.easeOut.transform(val) * 30,
                  width: Curves.easeOut.transform(val) * 100,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.star_rounded, color: Colors.yellow,size: Curves.easeOut.transform(val) * 17,),
                    Icon(Icons.star_rounded, color: Colors.yellow,size: Curves.easeOut.transform(val) * 17,),
                    Icon(Icons.star_rounded, color: Colors.yellow,size: Curves.easeOut.transform(val) * 17,),
                    Icon(Icons.star_rounded, color: Colors.grey,size: Curves.easeOut.transform(val) * 17,)],
                ),),
                //SizedBox(height: 10,),
               // Row(children: [Text('data'),],mainAxisAlignment: MainAxisAlignment.center,),
              ],
            ),
          ),
        ),

    );

  }
}