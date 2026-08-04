import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/riverpod/counter_notifier.dart';
import 'package:state_management/riverpod/theme_notifier.dart';

class CounterRiverpodScreen extends ConsumerWidget {
  const CounterRiverpodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 25,
            children: [
              buttonDecrement(ref),
              textCounter(ref),
              buttonIncrement(ref)
            ],
          ),
      ),
    );
  }



  Widget buttonIncrement(WidgetRef ref){

   
    return FilledButton(
      onPressed: (){
        ref.read(counterNotifier.notifier).increment();
        ref.read(themeNotifier.notifier).changeTextColor(ref.read(counterNotifier));
      },
      child: Text("+")
    );
  }

  Widget buttonDecrement(WidgetRef ref){
    
    
    return FilledButton(
      onPressed: (){
        ref.read(counterNotifier.notifier).decrement();

        ref.read(themeNotifier.notifier).changeTextColor(ref.read(counterNotifier));

        },
      child: Text("-")
    );
  }

  Widget textCounter(WidgetRef ref){
    
    
    return Consumer(
      builder: (context, widgetRef, child){
      
        final counter = widgetRef.watch(counterNotifier);
        final color = widgetRef.watch(themeNotifier);
        
        return Text(
          counter.toString(),
          style: TextStyle(fontSize: 32, color: color),
        );
      }
    );
  
  }


}