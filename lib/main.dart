import 'package:ar_flutter_plugin_flutterflow/ar_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:ar_test/widgets/objects_on_planes.dart';

//TODO: real device debug

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  static const String _title = 'AR Plugin Demo';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await ArFlutterPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: Column(children: [
          Text('Running on: $_platformVersion\n'),
          Expanded(
            child: ExampleList(),
          ),
        ]),
      ),
    );
  }
}

class ExampleList extends StatelessWidget {
  const ExampleList({super.key});

  @override
  Widget build(BuildContext context) {
    final examples = [
      Example(
          'Debug Options',
          'Visualize feature points, planes and world coordinate system',
              () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ObjectsOnPlanes()))),
    ];
    return ListView(
      children:
      examples.map((example) => ExampleCard(example: example)).toList(),
    );
  }
}

class ExampleCard extends StatelessWidget {
  const ExampleCard({super.key, required this.example});
  final Example example;

  @override
  build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          example.onTap();
        },
        child: ListTile(
          title: Text(example.name),
          subtitle: Text(example.description),
        ),
      ),
    );
  }
}

class Example {
  const Example(this.name, this.description, this.onTap);
  final String name;
  final String description;
  final Function onTap;
}