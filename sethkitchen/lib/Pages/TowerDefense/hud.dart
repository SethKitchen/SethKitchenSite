import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class HUD extends StatefulWidget {
  const HUD({required key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => HUDDefaultState();
}

class HUDDefaultState extends State<HUD> {
 
 Widget getDraggable(Widget widget) {
   return Draggable(child: widget, feedback: widget);
 }
 Widget getNFTSelector() {
   Widget nft1 = Container(color:Colors.green);
   Widget nft2 = Container(color:Colors.red);
   Widget nft3 = Container(color:Colors.pink);
   Widget nft4 = Container(color:Colors.black);
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: getDraggable(nft1),
        ),
         StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: getDraggable(nft2),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: getDraggable(nft3),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: getDraggable(nft4),)
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(children: [
      Expanded(child:Container(color:Colors.purple)),
      Container(color:Colors.blue, width:200, child:getNFTSelector())
    ]);
  }
}
