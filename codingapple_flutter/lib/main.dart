import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(
      MaterialApp(
          home:MyApp()
      )
    );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
      var contacts = await ContactsService.getContacts();
      print(contacts);
      setState(() {
        name = contacts;
      });
    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request();
    }
  }

  var a = 1;

  var name = [];

  var count = [0,0,0];

  addOne() {
    setState(() {
      a=a+1;
    });
  }

  addName(a){
    if(a!="") {
      setState(() {
        name.add(a);
        count.add(0);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.account_circle_sharp),
            onPressed: (){
              showDialog(context: context, builder: (context){
                return DialogUI(addOne : addOne, addName : addName);
              });
            }),
        appBar: AppBar(leading: Icon(Icons.bookmark_rounded),title: Text(a.toString()), actions: [IconButton(onPressed: (){ getPermission(); }, icon: Icon(Icons.contacts))], ),
        body: ListView.builder(
          itemCount: name.length,
          itemBuilder: (c,i){
            return ListTile(
              leading:  Icon(Icons.account_circle_sharp),
              title :Text(name[i].givenName),

            );
          }
        )

    );
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({Key? key ,this.addOne , this.addName}) : super(key: key);
  final addOne;
  final addName;
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SizedBox(
          height: 200,
          child: Column(
            children: [
              SizedBox(
                width: 100,
                height: 50,
                child: Text("Contact"),
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: inputData ,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact',
                    )
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){
                      addOne();
                      addName(inputData.text);
                      Navigator.of(context).pop();
                    }, child: Text("완료")
                    ),
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text("Cancel")),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}


