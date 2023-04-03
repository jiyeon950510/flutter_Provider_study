import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends StateNotifier<int>{
  Counter() : super(0); // 창고

  void increment(){
    state ++;
  }

}

final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});


void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int value = ref.watch(counterProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Text("$value"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            ref.read(counterProvider.notifier).increment();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}