import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mainpage6 extends StatefulWidget {
  const Mainpage6({super.key});

  @override
  State<Mainpage6> createState() => _Mainpage6State();
}

class _Mainpage6State extends State<Mainpage6> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Categories'),
        actions: [Icon(Icons.search)],
        leading: InkWell(onTap: (){Navigator.pop(context);},
        child: Icon(Icons.arrow_back_ios_new),)
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.white70,
                  width: 110,
                  height: 40,
                  child: Text(
                    'Women',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  color: Colors.white70,
                  width: 110,
                  height: 40,
                  child: Text(
                    'Men',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  color: Colors.white70,
                  width: 110,
                  height: 40,
                  child: Text(
                    'Kids',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Center(
                  child: Text(
                'SUMMER SALES \n up tp 50\% off',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
              height: 60,
              width: double.infinity,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  color: Colors.white70,
                  height: 120,
                  width: 200,
                  child: Center(
                      child: Text(
                    'New',
                    style: TextStyle(fontSize: 20),
                  )),
                ),
                Container(
                  height: 120,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      image: DecorationImage(
                          image: AssetImage('assets/images/img.png'))),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  height: 120,
                  width: 200,
                  child: Center(
                      child: Text(
                        'Clothes',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                Container(
                  height: 120,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      image: DecorationImage(
                          image: AssetImage('assets/images/img.png'))),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  height: 120,
                  width: 200,
                  child: Center(
                      child: Text(
                        'Shoes',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                Container(
                  height: 120,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      image: DecorationImage(
                          image: AssetImage('assets/images/img.png'))),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  height: 120,
                  width: 200,
                  child: Center(
                      child: Text(
                        'Accesories',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                Container(
                  height: 120,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      image: DecorationImage(
                          image: AssetImage('assets/images/img.png'))),
                )
              ],
            ),

          ],
        ),
      ),
      bottomSheet: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.house_sharp,size: 40,),
          Icon(Icons.shopping_cart_sharp,size: 40,),
          Icon(Icons.shopping_bag,size: 40,),
          Icon(Icons.favorite,size: 40,),
          Icon(Icons.person,size: 40,)
        ],
      ),
    );
  }
}
