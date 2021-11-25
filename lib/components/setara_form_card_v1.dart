import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fometic/utils/strutils/constants.dart';


class SetaraFormCard extends StatefulWidget{
  final String formTitle;
  final String formSubTitle;
  final List<Widget> children;
  const SetaraFormCard({ Key? key , required this.formTitle, this.formSubTitle = "", required this.children}) : super(key: key);


  @override
  State<SetaraFormCard> createState() => _SetaraFormCardState();
}

class _SetaraFormCardState extends State<SetaraFormCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(minPadding),
      child : Column(
        children: [
          Text(widget.formTitle, style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: minHeightPadding),
          LayoutBuilder(
            builder: (BuildContext subContext, BoxConstraints constraints) {
              if (constraints.maxWidth > 400) {
                return _buildWideContainers(subContext, widget.children);
              } else {
                return _buildNormalContainer(subContext, widget.children);
              }
            },
          ),
        ],
      )

    );
  }

  Widget _buildWideContainers(BuildContext subContext, List<Widget> children) {
    int childSize = children.length;

    List<Widget> newChildren = <Widget>[];
    for (var i=1;i<childSize+1;i++){
      if (i != childSize) {
        newChildren.add(
            Row(children: [Expanded(child: children.elementAt(i - 1), flex:1),
              const SizedBox(
                width: minPadding,
                height: minPadding,
              ),Expanded(child: children.elementAt(i),flex:1)]));
        newChildren.add(const SizedBox(
          width: minPadding,
          height: minPadding,
        ));
      }else {
        newChildren.add(children.elementAt(i - 1));
      }
      i+=1;
    }


    return Column(
      children:  newChildren,
    );
  }

  Widget _buildNormalContainer(BuildContext subContext, List<Widget> children) {
    int childSize = children.length;

    List<Widget> newChildren = <Widget>[];
    for (var i=0;i<childSize;i++){
      newChildren.add(children.elementAt(i));
      if(i != (childSize-1)){
        newChildren.add(const SizedBox(
          width: minPadding,
          height: minPadding,
        ));
      }
    }
    return Column(
      children : newChildren,
    );
  }

}