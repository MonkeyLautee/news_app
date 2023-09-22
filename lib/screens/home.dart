import 'package:flutter/material.dart';
import '../services/api_calls.dart';
import '../components/my_app_bar.dart';
import '../components/news_card.dart';
import 'select_category.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  bool _loading = true;
  List _news = [];
  String _location = 'New York';
  String _weather = 'Cloudy';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      List? latestNews = await APICalls.getNews();
      setState((){
        _news = latestNews??[];
        _loading = false;
      });
    });
  }

  Future<String?> getText(BuildContext context)async{
    bool okButtonPressed=false;
    final TextEditingController stringController = TextEditingController();
    await showDialog(
      context:context,
      builder:(context)=>SimpleDialog(
        contentPadding:const EdgeInsets.all(10.0),
        children:<Widget>[
          TextField(
            style:Theme.of(context).textTheme.bodyMedium,
            controller:stringController,
            autofocus:true,
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children:<Widget>[
              ElevatedButton(
                style:ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                child:const Text('Ok',style:TextStyle(color:Colors.white)),
                onPressed:(){
                  okButtonPressed=true;
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style:ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                child:const Text('Cancel',style:TextStyle(color:Colors.white)),
                onPressed:(){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
    return okButtonPressed?stringController.text.trim():null;
  }

  void _changeLocation()async{
    String? newLocation = await getText(context);
    if(newLocation==null)return;
    if(newLocation.trim()=='')return;
    setState(()=>_location=newLocation);
  }
  void _checkWeather()async{
    String? theWeather = await APICalls.getWeather(_location);
    setState(()=>_weather = theWeather??'Unknown');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: MyAppBar(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(23.0),
              ),
              child: Column(
                children: [
                  const SizedBox(height:12),
                  Text('Selected location: $_location',style:Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height:7),
                  Text('Weather: $_weather',style:Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height:7),
                  ElevatedButton(
                    onPressed: _checkWeather,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: const Text('Check weather'),
                  ),
                  ElevatedButton(
                    onPressed:_changeLocation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: const Text('Change location'),
                  ),
                  const SizedBox(height:12),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Text('Categories',style:Theme.of(context).textTheme.headlineSmall),
              InkWell(
                onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(x)=>const SelectCategory())),
                child: const Text('View all',style:TextStyle(decoration:TextDecoration.underline)),
              ),
            ],
          ),
          const SizedBox(height:13),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 55,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CategoryChip('Category 1',true),
                CategoryChip('Category 3',false),
                CategoryChip('Category 4',true),
                CategoryChip('Category 1',true),
                CategoryChip('Category 3',false),
                CategoryChip('Category 4',true),
              ],
            ),
          ),
          const SizedBox(height:13),
          Text('Latest news',style:Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height:13),
          _loading?const Center(child:CircularProgressIndicator(color:Colors.black)):Wrap(
            runSpacing: 16,
            children: _news.map((theNew)=>NewsCard(
              image: theNew['urlToImage']??'',
              title: theNew['title'],
              description: theNew['publishedAt'],
              bookmarked: true,
            )).toList(),
          ),
          const SizedBox(height:13),
          ElevatedButton(
            onPressed: ()async{
              setState(()=>_loading=true);
              List? latestNews = await APICalls.getNews();
              setState((){
                _news = latestNews??[];
                _loading = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child:const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String category;
  final bool selected;
  const CategoryChip(this.category,this.selected,{Key? key}):super(key:key);
  @override
  Widget build(BuildContext context)=>Padding(
    padding: const EdgeInsets.only(right:10),
    child: Chip(
      backgroundColor: selected?Colors.black:Colors.grey,
      label: Text(category,style:const TextStyle(color:Colors.white)),
    ),
  );
}