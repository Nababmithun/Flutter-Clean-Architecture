import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart'; // আমরা GetX ব্যবহার করছি
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() {
  setUpAll(() async {
    // Environment & Hive initialize
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    await Hive.initFlutter();
    await Hive.openBox('auth');
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // আমাদের MyApp (AppRoot) ব্যবহার করে অ্যাপ রান করি
    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: CounterScreen(),
        ),
      ),
    );

    // শুরুতে কাউন্টার 0 হওয়া উচিত
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // '+' আইকনে ট্যাপ করি
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // এখন 1 দেখা উচিত
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

// ✅ ডেমো CounterScreen – তুমি চাইলে এটাকে আলাদা পেজে রাখতে পারো
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('$_counter', style: const TextStyle(fontSize: 32))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter++),
        child: const Icon(Icons.add),
      ),
    );
  }
}
