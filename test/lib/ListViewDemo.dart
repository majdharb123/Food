import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget {
  const ListViewDemo({super.key});

  @override
  State<ListViewDemo> createState() => _ListViewDemoState();
}



class _ListViewDemoState extends State<ListViewDemo> {


final List<Map<String,String>>item=[
 {"Title":"CARTIER EYEWEAR","Subtitle":"400"}
,{"Title":"MIU MIU","Subtitle":"362"}
,{"Title":"PRADA EYEWEAR","Subtitle":"520"}
,{"Title":"OLIVER PEOPLES","Subtitle":"390"}
,{"Title":"LOEWE EYEWEAR","Subtitle":"640"}
,{"Title":"LOEWE EYEWEAR","Subtitle":"640"}

];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
backgroundColor:Color(0xFFF5F5DC) ,

body:ListView.builder(itemCount: item.length
,itemBuilder: (context,index){
return
 Center(child: Padding(padding: EdgeInsetsGeometry.all(20),
 child: Column(children: [SizedBox(height: 10,) 
 ,SizedBox(width: 400,height: 100,
 child: Card(color: Color.fromARGB(255, 250, 246, 226),
 child: ListTile(title: Text(item[index]['Title']!,style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
 ),subtitle: Text('\$${item[index]['Subtitle']! }',style: TextStyle(color: Colors.black),)
,)
 
 
 
 ,)
 ,)
 ]
 ,)
 ,)
 ,);





})
);



  }
}