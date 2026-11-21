import 'package:korochka/theme.dart';
import 'package:material_ui/material_ui.dart';

void main() => runApp(const KorochkaApp());

class KorochkaApp extends StatelessWidget {
  const KorochkaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Корочка',
      theme: buildAppTheme(),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(body: Center(child: Text('Корочка'))),
    );
  }
}
