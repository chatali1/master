import 'package:fitness/fitness.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

enum PermissionStatus {
  granted,
  denied,
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PermissionStatus _status = PermissionStatus.denied;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("before _reqstpermission");
   // print("  Fitness.read() : ${  Fitness.read()}");
    _requestPermission();
    // _hasPermission();
    print("after _reqstpermission");
  }

  /// Fitness Usage STARTED
  void _hasPermission() async {
    final result = await Fitness.hasPermission();
    print('[hasPermission]::$result');
    if (!mounted) {
      print("in mounted");
      return;
    }

    setState(() {
      _status = result ? PermissionStatus.granted : PermissionStatus.denied;
      print("_status: $_status");
    });

    if (_status != PermissionStatus.granted) {
      print("in if condition");
      return;
    }

    // _onFilterChanged(DateFilter.daily);
  }

  void _requestPermission() async {
    final result = await Fitness.requestPermission();
    print("in reqst permission");
    print('[requestPermission]::$result');
    _hasPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
