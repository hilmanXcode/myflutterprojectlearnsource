import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/provider/counter_provider.dart';
import 'package:state_management/provider/theme_provider.dart';

class CounterProviderScreen extends StatelessWidget {

  // final counter = CounterModel();

  const CounterProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 25,
            children: [
              buttonDecrement(context),
              textCounter(context),
              textCounter2(context),
              buttonIncrement(context)
            ],
          ),
      ),
    );
  }

  Widget buttonIncrement(BuildContext context){

    final counterModel = context.read<CounterModel>();
    final themeModel = context.read<ThemeModel>();    

    return FilledButton(
      onPressed: (){
        counterModel.incrementNumber();
        themeModel.changeTextColor(counterModel.counterNumber);
      },
      child: Text("+")
    );
  }

  Widget buttonDecrement(BuildContext context){
    
    final counterModel = context.read<CounterModel>();
    final themeModel = context.read<ThemeModel>();    
    
    return FilledButton(
      onPressed: (){
        counterModel.decrementNumber();
          themeModel.changeTextColor(counterModel.counterNumber);  
        },
      child: Text("-")
    );
  }

  Widget textCounter(BuildContext context){
    
    
    return Consumer<CounterModel>(
      builder: (context, counter, child) {
        return Text(
          counter.counterNumber.toString(),
          style: TextStyle(fontSize: 32),
        );
      }
    );
  }

  Widget textCounter2(BuildContext context){
    
    
    return Selector2<CounterModel, ThemeModel, (int, Color)>(
      selector: (context, counterModel, themeModel) => (counterModel.counterNumber, themeModel.textColor),
      builder: (context, value, child) {
        return Text(
          value.$1.toString(),
          style: TextStyle(fontSize: 32, color: value.$2),
        );
      }
    );
  }
}