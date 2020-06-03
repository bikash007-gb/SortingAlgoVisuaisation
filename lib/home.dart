import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
class Newhome extends StatefulWidget {
  @override
  _NewhomeState createState() => _NewhomeState();
}

class _NewhomeState extends State<Newhome> {
  List<int> _numbers=[];
  int _size=500;
  String _currentSortAlgo = 'bubble';
  StreamController<List<int>> _streamController;
  Stream<List<int>> _stream;
  bool isSorted=false;
  bool isSorting=false;
  _genrand(){
    isSorted = false;
    _numbers=[];
      for(int i=0;i<_size;++i){
        _numbers.add(Random().nextInt(_size));
      }
      //setState(() { });
      _streamController.add(_numbers);
  }
  _bubsort() async {
   for (int i=0;i<_numbers.length;++i){
    for(int j=0;j<_numbers.length-i-1;++j){
      if (_numbers[j]>_numbers[j+1]){
         int temp=_numbers[j];
         _numbers[j]=_numbers[j+1];
         _numbers[j+1]=temp;
      }
    await Future.delayed(Duration(microseconds: 500));
    _streamController.add(_numbers);
    }
  }
  }
  _selcetSort() async{
    for (int i = 0; i < _numbers.length; i++) {
      for (int j = i + 1; j < _numbers.length; j++) {
        if (_numbers[i] > _numbers[j]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[i];
          _numbers[i] = temp;
        }

        await Future.delayed(Duration(microseconds: 500));

        _streamController.add(_numbers);
      }
    }
  }
  _insertion() async{
     for (int i = 1; i < _numbers.length; i++) {
      int temp = _numbers[i];
      int j = i - 1;
      while (j >= 0 && temp < _numbers[j]) {
        _numbers[j + 1] = _numbers[j];
        --j;
        await Future.delayed(Duration(microseconds: 500));

        _streamController.add(_numbers);
      }
      _numbers[j + 1] = temp;
      
      await Future.delayed(Duration(microseconds: 500));
      _streamController.add(_numbers);
    }

  }
    cf(int a, int b) {
    if (a < b) {
      return -1;
    } else if (a > b) {
      return 1;
    } else {
      return 0;
    }
  }

   _quickSort(int leftIndex, int rightIndex) async {
    Future<int> _partition(int left, int right) async {
      int p = (left + (right - left) / 2).toInt();

      var temp = _numbers[p];
      _numbers[p] = _numbers[right];
      _numbers[right] = temp;
      await Future.delayed(Duration(microseconds: 1000));

      _streamController.add(_numbers);

      int cursor = left;

      for (int i = left; i < right; i++) {
        if (cf(_numbers[i], _numbers[right]) <= 0) {
          var temp = _numbers[i];
          _numbers[i] = _numbers[cursor];
          _numbers[cursor] = temp;
          cursor++;

         await Future.delayed(Duration(microseconds: 1000));
          _streamController.add(_numbers);
        }
      }

      temp = _numbers[right];
      _numbers[right] = _numbers[cursor];
      _numbers[cursor] = temp;

     await Future.delayed(Duration(milliseconds: 5));

      _streamController.add(_numbers);

      return cursor;
    }

    if (leftIndex < rightIndex) {
      int p = await _partition(leftIndex, rightIndex);

      await _quickSort(leftIndex, p - 1);

      await _quickSort(p + 1, rightIndex);
    }
  }
   
    _mergeSort(int leftIndex, int rightIndex) async {
    Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
      int leftSize = middleIndex - leftIndex + 1;
      int rightSize = rightIndex - middleIndex;

      List leftList = new List(leftSize);
      List rightList = new List(rightSize);

      for (int i = 0; i < leftSize; i++) leftList[i] = _numbers[leftIndex + i];
      for (int j = 0; j < rightSize; j++) rightList[j] = _numbers[middleIndex + j + 1];

      int i = 0, j = 0;
      int k = leftIndex;

      while (i < leftSize && j < rightSize) {
        if (leftList[i] <= rightList[j]) {
          _numbers[k] = leftList[i];
          i++;
        } else {
          _numbers[k] = rightList[j];
          j++;
        }

         await Future.delayed(Duration(microseconds: 1000));
        _streamController.add(_numbers);

        k++;
      }

      while (i < leftSize) {
        _numbers[k] = leftList[i];
        i++;
        k++;

         await Future.delayed(Duration(microseconds: 1000));
        _streamController.add(_numbers);
      }

      while (j < rightSize) {
        _numbers[k] = rightList[j];
        j++;
        k++;

        await Future.delayed(Duration(microseconds: 1000));
        _streamController.add(_numbers);
      }
    }

    if (leftIndex < rightIndex) {
      int middleIndex = (rightIndex + leftIndex) ~/ 2;

      await _mergeSort(leftIndex, middleIndex);
      await _mergeSort(middleIndex + 1, rightIndex);

       await Future.delayed(Duration(microseconds: 1500));

      _streamController.add(_numbers);

      await merge(leftIndex, middleIndex, rightIndex);
    }
  }

   _checkAndResetIfSorted() async {
    if (isSorted) {
      _genrand();
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  _setSortAlgo(String type) {
    setState(() {
      _currentSortAlgo = type;
    });
  }
  _sort() async{
    setState(() {
      isSorting=true;
    });
     await _checkAndResetIfSorted();
    switch (_currentSortAlgo) {
    case "bubble":
        await _bubsort();
        break;
    case "selection":
        await _selcetSort();
        break;
    case "Insertion":
        await _insertion();
        break;
    case "Quick":
        await _quickSort(0, _size.toInt() - 1);
        break;
    case "Merge":
        await _mergeSort(0, _size.toInt() - 1);
        break;
    }
    setState(() {
     
      isSorting=false;
       isSorted=true;
    });
  }
  @override
  void initState() {
    super.initState();
    _streamController=StreamController<List<int>>();
    _stream=_streamController.stream;
    _genrand();
  }
  
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:Text('Algos',style: TextStyle(color:Colors.white)),
        backgroundColor:Colors.black,
        iconTheme: IconThemeData(
      color: Colors.white, //change your color here
      ),
        actions: <Widget>[
          PopupMenuButton<String>(
            
            initialValue: _currentSortAlgo,
            itemBuilder: (context){
               return[
                 PopupMenuItem(
                  value: 'bubble',
                  child: Text("Bubble Sort"),
                ),
                PopupMenuItem(
                  value: 'selection',
                  child: Text("Selection Sort"),
                ),
                PopupMenuItem(
                  value: 'Insertion',
                  child: Text("Interstion Sort"),
                ),
                PopupMenuItem(
                  value: 'Merge',
                  child: Text("Merge Sort"),
                ),
                PopupMenuItem(
                  value: 'Quick',
                  child: Text("Quick Sort"),
                ),
               ];
            },
            onSelected: (String value){
              _genrand();
              _setSortAlgo(value);
            },
             
            )
        ],
      ),
      
      body: Container(
        child:StreamBuilder<Object>(
          stream: _stream,
          builder: (context, snapshot) {
          int counter=0;
            return Row(
              children:_numbers.map((int number){
                counter++;
                return CustomPaint(
                   painter: BarPainter(
                     width:MediaQuery.of(context).size.width/_size,
                     value:number,
                     index:counter
                   ),
                );
              }
            ).toList()
      );
          }
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child:Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                           Colors.green,
                           Colors.blue
                         ] 
                )
              ),
              child: FlatButton(
                onPressed: isSorting
                        ? null
                        : () {
                            _genrand();
                            _setSortAlgo(_currentSortAlgo);
                          }, 
                              child: Text('Reset')),
            ) ,
                            
                            ),
                            Expanded(
                          child:Container(
                          decoration: BoxDecoration(
                       gradient: LinearGradient(
                      colors: [
                           Colors.red,
                           Colors.blue
                         ] 
                        )
                      ),

                            child: FlatButton(
                              onPressed: isSorting ? null : _sort, 
                              child: Text('Sort')),
                          ) ,
                            
                            )
                      ],
                    ),
                  );
                }
              
                
}
  
class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int index;
  BarPainter({this.width,this.value,this.index});
  @override
  void paint(Canvas canvas, Size size) {
      Paint paint=Paint();
     if (this.value < 500 * .10) {
      paint.color = Colors.grey;
    } else if (this.value < 500 * .20) {
      paint.color = Colors.green[100];
    } else if (this.value < 500 * .30) {
      paint.color = Colors.pink[200];
    } else if (this.value < 500 * .40) {
      paint.color = Colors.cyan[300];
    } else if (this.value < 500 * .50) {
      paint.color =Color(0xFF0E4D64);
    } else if (this.value < 500 * .60) {
      paint.color = Colors.yellow[500];
    } else if (this.value < 500 * .70) {
      paint.color = Colors.blue[600];
    } else if (this.value < 500 * .80) {
      paint.color = Colors.orange[700];
    } else if (this.value < 500 * .90) {
      paint.color = Colors.white;
    } else {
      paint.color = Colors.red[900];
    }

      paint.strokeWidth=width;
      paint.strokeCap=StrokeCap.round;
      
      canvas.drawLine(Offset(index * this.width,0), Offset(index * this.width,this.value.ceilToDouble()), paint); 
    }
  
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
     return true;
  }

}