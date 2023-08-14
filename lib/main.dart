import 'package:flutter/material.dart';
import 'package:weather_app/data_fetcher.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomeState();
}


class _HomeState extends State<HomePage> with SingleTickerProviderStateMixin{
  late String name;
  late String region;
  late String country;
  late String localtime;
  late double temp_c;
  late double temp_f;
  late String condition;
  late int humidity;
  late int cloud;
  late double co;
  late double o3;
  late double no2;
  late double so2;
  late Map<dynamic,dynamic> bodyMap;
  late Map<String,dynamic> locationMap;
  late Map<String,dynamic> currentMap;
  late Map<String,dynamic> conditionMap;
  late Map<String,dynamic> airMap;

  Data data_fetcher = Data();
  String text = "";
  late double maxHeight;
  late double maxWidth;

  late Animation<double> animation;
  late AnimationController controller;

  TextEditingController inputCityName = TextEditingController();

  void dataFill() async{
    bodyMap = await data_fetcher.getComing();
    setState(() {
    locationMap = bodyMap['location'];
    currentMap = bodyMap['current'];
    conditionMap = currentMap['condition'];
    airMap = currentMap['air_quality'];
    name = locationMap['name'];
    region = locationMap['region'];
    country = locationMap['country'];
    localtime = locationMap['localtime'];
    temp_c = currentMap['temp_c'];
    temp_f = currentMap['temp_f'];
    condition = conditionMap['text'];
    humidity = currentMap['humidity'];
    cloud = currentMap['cloud'];
    co = airMap['co'];
    o3 = airMap['o3'];
    no2 = airMap['no2'];
    so2 = airMap['so2'];
    });
  }

  @override
  void initState(){
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      setState(() {
        
      });
    });
    // data.refreshData().listen((event) {
    //   setState(() {
    //     text = data.localtime;
    //   });
    // },);
    super.initState();
    dataFill();
    controller.forward();
  }

  @override
  Widget build(BuildContext context){
    if(animation.value == 100){
      text = localtime;
      return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
        maxHeight = constraints.maxHeight;
        maxWidth = constraints.maxWidth;
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 21, 89, 111),
                  Color.fromARGB(20, 20, 168, 215)
                ]
              )
            ),
            width: maxWidth,
            height: maxHeight,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    width: maxWidth + 20 - maxWidth / 4,
                    height: 40,
                    margin: const EdgeInsets.fromLTRB(10, 38, 0, 0),
                    decoration: const BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid
                      )),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Search for cities..",
                        border: InputBorder.none,
                        
                      ),
                      controller: inputCityName,

                    ),

                  )
                ),
                Positioned(right: 10,top:35,width: 50,height: 50,child: GestureDetector(
                  onTap: () async{
                    await data_fetcher.searchCities(inputCityName.text);
                    dataFill();
                  }, 
                  child: Image.asset('assets/search.png'),
                )),
                Positioned(top: 75,child: Container(
                  width: maxWidth,
                  height: 200,
                  decoration: const BoxDecoration(
                    // border: Border.fromBorderSide(BorderSide(
                    //   color:Colors.black,
                    //   width: 1,
                    //   style: BorderStyle.solid
                    // ))
                  ),
                  child: Center(
                    child: Container(
                      height: 150,
                      width: maxWidth / 1.3,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(51, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                        child: Column(
                          children: [
                            Text(name, style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600
                              
                            ),),
                            const Padding(padding: EdgeInsets.all(7)),
                            Text("$country / $region", style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              
                            ),),
                          ],
                        ))
                      ),
                    ),
                  ),
                )),
                // ignore: sized_box_for_whitespace
                Positioned(top: 265,child: Container(
                  width: maxWidth,
                  child: Center(child: Text("Updated : $localtime",style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400
                  ),)),
                )),
                Positioned(top:300,child: Container(
                  width: maxWidth,
                  height: 240,
                  decoration: const BoxDecoration(
                    // border: Border.fromBorderSide(BorderSide(
                    //   color:Colors.black,
                    //   width: 1,
                    //   style: BorderStyle.solid
                    // ))
                  ),
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(10)),
                      Text(condition, style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,

                      ),),
                      const Padding(padding: EdgeInsets.all(5)),
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.all(12)),
                          Container(
                            width: maxWidth/2.7,
                            height: 179,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(51, 255, 255, 255),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Stack(
                              children: [
                                const Positioned(top:5,left:5, child: Text("Temperature:", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),)),
                                Positioned(top:35,left:10,child: Text("$temp_c", style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 43,
                                ))),
                                const Positioned(right:35,top:33,child: Text("o", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ))),
                                const Positioned(right:18,top:39,child: Text("C", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ))),
                                Positioned(top:110,left:10,child: Text("$temp_f", style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 43,
                                ))),
                                const Positioned(right:35,top:108,child: Text("o", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ))),
                                const Positioned(right:18,top:114,child: Text("F", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                )))
                              ],
                            )
                          ),
                          const Padding(padding: EdgeInsets.all(26)),
                          Container(
                            width: maxWidth/2.7,
                            height: 179,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(51, 255, 255, 255),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Stack(
                              children: [
                                const Positioned(top:5,left:5, child: Text("Cloud:", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),)),
                                Positioned(top:35,left:10,child: Text("$cloud", style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 43,
                                ))),
                                const Positioned(top:90,left:5, child: Text("Humidity:", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),)),
                                Positioned(top:110,left:10,child: Text("$humidity", style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 43,
                                ))),
                              ],
                            )
                          )
                        ],
                      )
                    ],
                  )
                )),
                Positioned(top:540,child: Container(
                  width: maxWidth,
                  height: 240,
                  decoration: const BoxDecoration(
                    // border: Border.fromBorderSide(BorderSide(
                    //   color:Colors.black,
                    //   width: 1,
                    //   style: BorderStyle.solid
                    // ))
                  ),
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(10)),
                      const Text("air quality", style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,

                      ),),
                      const Padding(padding: EdgeInsets.all(5)),
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.all(12)),
                          Container(
                            width: maxWidth/2.7,
                            height: 179,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(20, 20, 168, 215),
                                  Color.fromARGB(10, 0, 0, 0)
                                ]
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Stack(
                              children: [
                                const Positioned(top:5,left:5, child: Text("CO:", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),)),
                                Positioned(top:35,left:10,child: Text("$co", style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 43,
                                ))),
                                const Positioned(top:90,left:5, child: Text("O3:", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),)),
                                Positioned(top:110,left:10,child: Text("$o3", style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 43,
                                ))),
                              ],
                            )
                          ),
                          const Padding(padding: EdgeInsets.all(26)),
                          Container(
                            width: maxWidth/2.7,
                            height: 179,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(20, 20, 168, 215),
                                  Color.fromARGB(10, 0, 0, 0)
                                ]
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Stack(
                              children: [
                                const Positioned(top:5,left:5, child: Text("NO2:", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),)),
                                Positioned(top:35,left:10,child: Text("$no2", style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 43,
                                ))),
                                const Positioned(top:90,left:5, child: Text("SO2:", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),)),
                                Positioned(top:110,left:10,child: Text("$so2", style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 43,
                                ))),
                              ],
                            )
                          )
                        ],
                      )
                    ],
                  )
                ))
              ]
            ),
          )
        );
      });
      
    }else{
      return const Scaffold(
        body: Center(child: Text("loading.."))
      );
    }

    
  }
}