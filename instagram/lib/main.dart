import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c)=>Store1()),
          ChangeNotifierProvider(create: (c)=>Store2()),
        ],
        child: MaterialApp(
          // theme: style.theme,
          initialRoute: '/',
          routes: {
            '/' : (c) => MyApp(),
            '/detail' : (c) => Text('둘째페이지'),
          },
        ),
      )
          
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var tab = 0;

  var Newdata = [];
  var Rebot = 0;
  var userImage;
  var userContent;



  addMyData(){
    var myData = {
      'id': Newdata.length,
      'image': userImage,
      'likes': 5,
      'date': 'July 25',
      'content': userContent,
      'liked': "true",
      'user': 'John Kim'
    };
    setState(() {
      print(myData);
      Newdata.insert(0, myData);
    });
  }

  setUserContent(a) {
    setState(() {
      userContent = a;
    });
  }

  addNewdata( addData ){
    setState(() {
      Rebot++;
    });
    return Newdata.add(addData);
  }



  getData() async {
    var result = await http.get( Uri.parse('https://codingapple1.github.io/app/data.json') );
    if (result.statusCode == 200) {
      Newdata=jsonDecode(result.body);
      setState(() {
      });
    } else {
      throw Exception('실패함ㅅㄱ');
    }

  }
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(Newdata.isNotEmpty){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Instagram'),
          actions: [
            IconButton(
              onPressed: () async {
                var picker = ImagePicker();
                var image = await picker.pickImage(source: ImageSource.gallery);
                // var video = await picker.pickVideo(source: ImageSource.gallery);
                // var image = await picker.pickMultiImage();
                if(image != null){
                  setState(() {
                    userImage=File(image.path);
                  });
                }

                Navigator.push(context,
                  MaterialPageRoute(builder: (context){ return Upload(userImage : userImage , setUserContent : setUserContent, addMyData : addMyData);} )
                );
              },
              icon: Icon(Icons.add_box_outlined),
              iconSize: 30,
            )
          ],
        ),
        body: [ Feed(Newdata:Newdata, addNewdata:addNewdata , Rebot:Rebot ) , Text('샵페이지')][tab],
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: (i){
            setState(() {
              tab = i;
            });
          },
          items: [
            BottomNavigationBarItem(
                label : '홈',
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
                label : '샵',
                icon: Icon(Icons.shopping_bag_outlined),
                activeIcon: Icon(Icons.shopping_bag)
            )
          ],
        ),
      );
    }
    else {
      return Text("로딩페이지");
    }



  }
}

class Feed extends StatefulWidget {
  const Feed({Key? key, this.Newdata , this.addNewdata, this.Rebot}) : super(key: key);
  final Newdata;
  final addNewdata;
  final Rebot;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  var scroll = ScrollController();
  getMore() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var result2 = jsonDecode(result.body);
    widget.addNewdata(result2);
  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      // print(scroll.position.pixels); //픽셀 위치
      // print(scroll.position.maxScrollExtent); //스크롤바 최대 내릴수 있는 높이
      // print(scroll.position.userScrollDirection); // 스크롤되는 방향
      if(scroll.position.maxScrollExtent==scroll.position.pixels){
        print('데이터추가');
        getMore();
        // addNewdata( )
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(itemCount: widget.Newdata.length, controller: scroll , itemBuilder: (c,i){
        return Article(Newdata:widget.Newdata[i]);
          }
      ),
    );
  }
}

class Article extends StatefulWidget {
  Article({Key? key,this.Newdata}) : super(key: key);
  final Newdata;

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {

  var liked=1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.Newdata['image'].runtimeType==String?Image.network(widget.Newdata['image'],fit: BoxFit.scaleDown,):Image.file(widget.Newdata['image'],fit: BoxFit.scaleDown),
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        IconButton(onPressed: (){
                          print(widget.Newdata['liked']);
                        }, icon: [Icon(Icons.favorite,color: Colors.pink,),Icon(Icons.favorite_outline,color: Colors.pink,)][(widget.Newdata['liked']=="true"?0:1)]),
                        Text("좋아요 "),
                        Text(widget.Newdata['likes'].toString()),
                      ],
                    )
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                        CupertinoPageRoute(builder: (c){
                          return Profile();
                        })
                        //   PageRouteBuilder(
                        //     pageBuilder: (c,a1,a2){
                        //       return Profile();
                        //     },
                        //     transitionsBuilder: (c,a1,a2,child)=>
                        //         FadeTransition(opacity: a1,child: child,),
                        //     transitionDuration: Duration(milliseconds: 500),
                        //
                        //   )

                        //   PageRouteBuilder(
                        //     pageBuilder: (c,a1,a2){
                        //       return Profile();
                        //     },
                        //     transitionsBuilder: (c,a1,a2,child)=>
                        //         SlideTransition(
                        //             position: Tween(
                        //               begin: Offset(-0.1,0.0),
                        //               end: Offset(0.0,0.0),
                        //             ).animate(a1),
                        //         child: child ,),
                        //     transitionDuration: Duration(milliseconds: 500),
                        //   )
                      );
                    },
                    child: Text(widget.Newdata['user'].toString()),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Text(widget.Newdata['date'].toString()),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Text(widget.Newdata['content'].toString()),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Store1 extends ChangeNotifier {
  var name = "kim chan hee";
  ChangeNameJ(){
    name = 'john park';
    notifyListeners();
  }
  ChangeNameC(){
    name = 'chan hee';
    notifyListeners();
  }
}

class Store2 extends ChangeNotifier {
  var name = 'john kim';
  var friend = false;
  var follower = 0;
  var profileImage = [];

  getData() async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var result2= jsonDecode(result.body);
    profileImage=result2;
  }

  addFollower(){
    if (friend == false) {
      follower++;
      friend = true;
    } else {
      follower--;
      friend = false;
    }
    notifyListeners();
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.watch<Store2>().name)),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
          ),
          Text('팔로워 ${context.watch<Store2>().follower}명'),
          ElevatedButton(onPressed: (){
            context.read<Store2>().addFollower();
          }, child: Text('팔로우')),
          ElevatedButton(onPressed: (){
            context.read<Store2>().getData();
          }, child: Text('사진가져오기'))
        ],
      ),
    );
  }
}



class Upload extends StatelessWidget {
  const Upload({Key? key, this.userImage , this.setUserContent, this.addMyData}) : super(key: key);

  final userImage;
  final setUserContent;
  final addMyData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            addMyData();
          }, icon: Icon(Icons.send))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          [Text('이미지없음'),Image.file(userImage)][userImage==null?0:1],
          Text("이미지업로드화면"),
          TextField(
            onChanged: (text){
              setUserContent(text);
            },
          ),
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
    );
  }
}

