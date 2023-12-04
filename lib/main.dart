
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async' show Future, StreamSubscription;
import 'dart:math';
import 'package:sensors/sensors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sms/flutter_sms.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  final double _shakeThreshold = 17.0;
  String _phoneNumber = '9543913949';
  
  /*FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  StreamSubscription? _recorderStatusSubscription;
  StreamSubscription? _audioStreamSubscription;
  String _filePath = '';
  */

  Future<void> _getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phoneNumber = prefs.getString('phoneNumber');
    if (phoneNumber != null) {
      setState(() {
        _phoneNumber = phoneNumber;
      });
    }
  }

  Future<void> _updatePhoneNumber(String newNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', newNumber);
    setState(() {
      _phoneNumber = newNumber;
    });
  }



  @override
  void initState() {
    super.initState();
    _getPhoneNumber();
    _streamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      if (event != null) {
        double x = event.x;
        double y = event.y;
        double z = event.z;

        double acceleration = _calculateAcceleration(x, y, z);

        if (acceleration > _shakeThreshold) {
          _makePhoneCall();
        }
      }
    });
  }
double _calculateAcceleration(double x, double y, double z) {
    double acceleration = sqrt(x * x + y * y + z * z);
    return acceleration;
  }

  Future<void> _makePhoneCall() async {
    final url = 'tel:$_phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


Future<void> _sendPanicSMS() async {
  final locationData = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  final latitude = locationData.latitude;
  final longitude = locationData.longitude;
  final message = "Help! I'm in danger. My current location is: https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

  final recipients = ['9362903540', '9894959181'];
  try {
    await sendSMS(message: message, recipients: recipients);
  } catch (error) {
    print(error.toString());
  }
}

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }
  late String newNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IWSA App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:<Widget> [
            DrawerHeader(
              child: Text('Women Safety Tips',style: TextStyle(fontSize: 24,color: Colors.white),),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
             ListTile(
              title: Text('Enter New Phone Number'),
              trailing: Icon(Icons.edit),
              onTap: () async {
                newNumber = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Enter New Phone Number'),
                      content: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(hintText: 'Enter Phone Number'),
                        onChanged: (value) {
                          newNumber = value;
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Save'),
                          onPressed: () {
                            _updatePhoneNumber(newNumber);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text('Sexual assault and harassment'),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Item1Page()),
              );
              },
            ),
            ListTile(
              title: Text('Robbery or chain snatching'),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Item2Page()),
              );
              },
            ),
            ListTile(
              title: Text('Eve-teasing'),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Item3Page()),
              );
              },
            ),
            ListTile(
              title: Text('Dowry deaths'),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Item4Page()),
              );
              },
            ),
            ListTile(
              title: Text('Honour killings'),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Item5Page()),
              );
              },
            ),
            ListTile(
              title: Text('Female infanticide and sex-selective abortion'),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Item6Page()),
              );
              },
            ),
            ListTile(
              title: Text('Domestic violence'),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Item7Page()),
              );
              },
            ),
            ListTile(
              title: Text('Forced child marriage'),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Item8Page()),
              );
              },
            ),
            ListTile(
              title: Text('Acid throwing'),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Item9Page()),
              );
              },
            ),
            ListTile(
              title: Text('Online bullying'),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Item10Page()),
              );
              },
            ),
          ],
        ),
      ),
      body:Center(child:
        ElevatedButton(
  onPressed: () {
    _sendPanicSMS();
  },
  child: Container(
    width: 100.0, // Replace with the desired width
    height: 100.0, // Replace with the desired height
    decoration: BoxDecoration(
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Text(
        'SOS',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ),
  style: ElevatedButton.styleFrom(
    primary: Colors.red,
    elevation: 4.0,
    shape: CircleBorder(),
    ),
    ),
  ),
  );
  }
}



class Item1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sexual assault and harassment'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek medical attention immediately.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Report the incident to the police as soon as possible.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Report the incident to the police as soon as possible.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Item2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Robbery or chain snatching'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Report the incident to the police as soon as possible.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Preserve any evidence, such as CCTV footage or eyewitness accounts.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Cancel any credit or debit cards that were stolen, and change any passwords associated with them.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Item3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eve-teasing'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'If possible, confront the perpetrator and ask them to stop their behaviour.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek help from bystanders or authorities if necessary.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Report the incident to the police as soon as possible.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Preserve any evidence, such as CCTV footage or eyewitness accounts.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek emotional and psychological support from friends, family, or a therapist.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Item4Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dowry deaths'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek medical attention immediately, if needed.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Report the incident to the police as soon as possible.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Preserve any evidence, such as letters, photographs, or witnesses to the dowry demand.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek legal aid from a lawyer, who can help you file a case under the Dowry Prohibition Act.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek emotional and psychological support from friends, family, or a therapist.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Item5Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Honour killings'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek immediate safety if you feel threatened.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Report the incident to the police as soon as possible.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Preserve any evidence, such as witnesses or threats made against you or your family.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek legal aid from a lawyer, who can help you file a case under the Protection of Women from Domestic Violence Act or the Indian Penal Code.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek emotional and psychological support from friends, family, or a therapist.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Item6Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Female infanticide and sex-selective abortion'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Report any incidents of female infanticide or sex-selective abortion to the police as soon as possible.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Support education and awareness campaigns that promote the value of girl children.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Advocate for legal and policy changes that enforce laws against gender discrimination and female infanticide/feticide.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek emotional and psychological support from friends, family, or a therapist.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Item7Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Domestic violence'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek medical attention immediately, if needed.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Report the incident to the police as soon as possible.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek legal aid from a lawyer, who can help you file a case under the Protection of Women from Domestic Violence Act or the Indian Penal Code.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek support from women\'s organizations or counseling services that can provide shelter and emotional support.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek emotional and psychological support from friends, family, or a therapist.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Item8Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forced child marriage'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek legal aid from a lawyer, who can help you file a case under the Prohibition of Child Marriage Act or the Indian Penal Code.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Advocate for education and awareness campaigns that promote the value of education and discourage child marriage.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek support from women\'s organizations or counselling services that can provide shelter and emotional support.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Item9Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acid throwing'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek medical attention immediately.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Report the incident to the police as soon as possible.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Preserve any evidence, such as CCTV footage or eyewitness accounts.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek legal aid from a lawyer, who can help you file a case under the Indian Penal Code or the Criminal Law Amendment Act.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Item10Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online bullying'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Document the abuse.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Report the abuse to the platform or law enforcement.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Protect your privacy.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Seek emotional support.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '• ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Educate yourself and others on online safety and security.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}
