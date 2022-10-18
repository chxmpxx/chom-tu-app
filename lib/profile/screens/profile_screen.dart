import 'package:chom_tu/configs/themes/constants.dart';
import 'package:chom_tu/outfit/widgets/overlayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: kColorsWhite,
//       body: Center(
//         child: Text('Coming soon...'),
//       ),
//     );
//   }
// }

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  List<Widget> _addWidgets = [];
  bool _showDeleteBtn = false;
  bool _isDeleteBtnActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Story'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(_addWidgets.length < _dummyWidgets.length) {
            setState(() {
              _addWidgets.add(
                OverlayedWidget(
                  key: Key(_addWidgets.length.toString()),
                  child: _dummyWidgets.elementAt(_addWidgets.length),
                  onDragStart: (){
                    if(!_showDeleteBtn) {
                      setState(() {
                        _showDeleteBtn = true;
                      });
                    }  
                  },
                  onDragEnd: (offset, key){
                    if(_showDeleteBtn) {
                      setState(() {
                        _showDeleteBtn = false;
                      });
                    }

                    if(offset.dy > (MediaQuery.of(context).size.height - 100)) {
                      _addWidgets.removeWhere((widget) => widget.key == key);
                    }
                  },
                  onDragUpdate: (offset, key){
                    if(offset.dy > (MediaQuery.of(context).size.height - 100)) {
                      if(!_isDeleteBtnActive) {
                        setState(() {
                          _isDeleteBtnActive = true;
                        });
                      }
                    }
                    else {
                      if(_isDeleteBtnActive) {
                        setState(() {
                          _isDeleteBtnActive = false;
                        });
                      }
                    }
                  },
                )
              );
            });
          }
        },
        child: Icon(Icons.add),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            color: Colors.purpleAccent,
          ),

          for(int i = 0; i < _addWidgets.length; i++) 
          _addWidgets[i],
          
          if(_showDeleteBtn)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Icon(Icons.delete, size: _isDeleteBtnActive ? 38 : 28, color: _isDeleteBtnActive ? Colors.red : Colors.yellow,),
            ),
          )
        ]
      )
    );
  }

  final List<Widget> _dummyWidgets = [
    Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(color: kColorsWhite, width: 2.5)
          ),
          child: Icon(Icons.favorite, size: 150, color: Colors.red,)
        ),
        SvgPicture.asset('assets/o1_false_circle_1.svg'),
      ],
    ),
    Icon(Icons.favorite, size: 150, color: Colors.black,),
  ];

}