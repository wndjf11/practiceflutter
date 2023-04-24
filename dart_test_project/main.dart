// void main() {
//   String  name = "찬희";
//   name = "1";
//   print(name);
// }

// ===============================

// bool isEmpty(String string) => string.length == 0;
// void main() {
//   // isEmpty(null);
//   String? nico = 'nico';
//   nico = null;
//   // if(nico != null){
//   //   nico.isNotEmpty;
//   // }
//   nico?.isNotEmpty;
// }

// ===============================

// void main() {
//   // dynamic hello = "hi";
//   // hello = 1;

//   // print(hello);

//   final String name="찬";
//   // name="희";
// }

// void main() {
//   late final String name;
//   name = "chance" ;
// }

// void main() {
//   // var numbers=[1,2,3,4];
//   bool giveMeFive = true;
//   List<int> number = [
//     1,
//     2,
//     3,
//     4,
//     if (giveMeFive) 5,
//   ];
//   // number.add(1);
//   print(number);
//   // number.removeLast();
//   // print(number);
//   // number.remove(2);
//   // print(number);
//   // number.remove(1);
//   // print(number);
//   // number.remove(1);
//   // print(number);
// }

// void main() {
//   var name = "찬희";
//   var age = 28;
//   var greeting = "안녕 내 이름은 $name 입니다. 내 나이는 ${age + 2} 입니다. 만나서 반가워요";
//   print(greeting);
// }

// void main() {
//   var oldFriends = ['nico', 'lynn'];
//   var newFriends = [
//     'lewis',
//     'ralph',
//     'derren',
//     for (var friend in oldFriends) "❤ $friend"
//   ];
//   print(newFriends);
// }

// void main() {
//   // var player = {
//   //   'name': 'nico',
//   //   'xp': 19.99,
//   //   'superpower': false,
//   // };
//   // Map<int, bool> player = {
//   //   1: true,
//   //   2: false,
//   //   3: true,
//   // };

//   // Map<List<int>,bool>player={
//   //   [1,2,3,4,5,6]:true,
//   //   [7,8,9,10]:false,
//   // };

//   List<Map<String, Object>> player = [
//     {'name': 'nico', 'xp': 1999993.1999},
//     {'name': 'nico', 'xp': 1999993.1999},
//   ];

//   print(player);
// }

// void sayhello(String name){
//   print("Hello $name nice to meet you!");
// }

// void sayhello(String name) => print("Hello $name nice to meet you!");

// num plus(num a, num b) => a + b;

// void main() {
//   sayhello("찬희");
// }

// String sayHello(String name, int age, {String? country = "korea"}) =>
//     "Hello $name, you are $age years old from $country";

// void main() {
//   var result = sayHello("chan", 28);
//   print(result);
// }

// class Player {
//   //final String name = 'chan';
//   String name = 'chan';
//   int xp = 1500;

//   void sayHello() {
//     print("hi my name is $name");
//   }
// }

// void main() {
//   var player = Player();
//   print(player.name);
//   player.name = "hee";
//   print(player.name);

//   player.sayHello();
// }

// class Player {
//   //final String name = 'chan';
//   final String name;
//   int xp;

//   Player(this.name, this.xp);

//   void sayHello() {
//     print("hi my name is $name");
//   }
// }

// void main() {
//   var player = Player("chan", 1500);
//   // print(player.name);
//   player.sayHello();
//   var player2 = Player("hee", 2500);
//   player2.sayHello();
// }

// class Player {
//   //final String name = 'chan';
//   final String name;
//   int xp;
//   String team;
//   int age;

//   Player(
//       {required this.name,
//       required this.xp,
//       required this.team,
//       required this.age});

//   void sayHello() {
//     print("hi my name is $name");
//   }
// }

// void main() {
//   var player = Player(name: "chan", xp: 1500, team: 'red', age: 12);
//   // print(player.name);
//   player.sayHello();
//   var player2 = Player(name: "hee", xp: 2500, team: 'blue', age: 12);
//   player2.sayHello();
// }

// class Player {
//   //final String name = 'chan';
//   final String name;
//   int xp;
//   String team;
//   int age;

//   Player(
//       {required this.name,
//       required this.xp,
//       required this.team,
//       required this.age});
//   Player.createBluePlayer({required String name, required int age})
//       : this.age = age,
//         this.name = name,
//         this.team = "blue",
//         this.xp = 0;
//   Player.createRedPlayer({required String name, required int age})
//       : this.age = age,
//         this.name = name,
//         this.team = "red",
//         this.xp = 0;

//   void sayHello() {
//     print("hi my name is $name");
//   }
// }

// void main() {
//   var player = Player.createBluePlayer(name: "chan", age: 12);
//   player.sayHello();
//   var player2 = Player.createRedPlayer(name: "hee", age: 12);
//   player2.sayHello();
// }

// class Player {
//   late final String name;
//   int xp;
//   String team;

//   Player({
//     required this.name,
//     required this.xp,
//     required this.team,
//   });
//   Player.createBluePlayer({required String name, required int age})
//       : this.name = name,
//         this.team = "blue",
//         this.xp = 0;
//   Player.createRedPlayer({required String name, required int age})
//       : this.name = name,
//         this.team = "red",
//         this.xp = 0;

//   void sayHello() {
//     print("hi my name is $name");
//   }
// }

// void main() {
//   var chan = Player(name: "chan", xp: 1200, team: "red")
//     ..name = "kkk"
//     ..team = "blue"
//     ..xp = 150000;
// }

enum Team { red, blue }

class Player {
  late final String name;
  int xp;
  Team team;

  Player({
    required this.name,
    required this.xp,
    required this.team,
  });
  Player.createBluePlayer({required String name, required int age})
      : this.name = name,
        this.team = Team.blue,
        this.xp = 0;
  Player.createRedPlayer({required String name, required int age})
      : this.name = name,
        this.team = Team.red,
        this.xp = 0;

  void sayHello() {
    print("hi my name is $name");
  }
}

void main() {
  var chan = Player(name: "chan", xp: 1200, team: Team.red)
    ..name = "kkk"
    ..team = Team.blue
    ..xp = 150000;
}
