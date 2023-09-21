import 'package:flutter/material.dart';
import '../components/my_app_bar.dart';
import '../components/my_button.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({Key? key}) : super(key: key);
  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {

	List<Map<String,dynamic>> _categories=[
		{'name': 'Category 1','selected': true},
		{'name': 'Category 2','selected': false},
		{'name': 'Category 3','selected': false},
		{'name': 'Category 4','selected': false},
		{'name': 'Category 5','selected': false},
		{'name': 'Category 6','selected': false},
	];

	@override
  Widget build(BuildContext context) {
    return Scaffold(
    	backgroundColor: Theme.of(context).colorScheme.background,
    	appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: MyAppBar(title:'Select categories'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
        	Wrap(
        		alignment: WrapAlignment.spaceEvenly,
        		spacing: 10,
        		runSpacing: 10,
        		children: _categories.map((Map<String,dynamic> category)=>MyCategory(
        			onTap:()=>setState((){
        				int index = _categories.indexOf(category);
        				_categories[index]['selected'] = !_categories[index]['selected'];
        			}),
        			name:category['name'],
        			selected:category['selected'],
        		)).toList(),
        	),
        	const SizedBox(height:12),
        	MyButton('Aplicar filtros',()=>Navigator.pop(context)),
        ],
      ),
    );
  }
}

class MyCategory extends StatelessWidget {
	final VoidCallback onTap;
	final String name;
	final bool selected;
  const MyCategory({required this.onTap,required this.name,required this.selected,Key? key}):super(key:key);
  @override
  Widget build(BuildContext context)=>InkWell(
  	onTap:onTap,
  	child: Container(
	  	width: MediaQuery.of(context).size.width*0.40,
	  	height: MediaQuery.of(context).size.width*0.40,
	  	decoration: BoxDecoration(
	  		color:selected?Colors.black:Colors.white,
		    borderRadius: BorderRadius.circular(23.0),
		  ),
		  child: Column(
	  		mainAxisAlignment:MainAxisAlignment.center,
	  		children: [
	  			Icon(Icons.chrome_reader_mode,size:47,color:selected?Colors.white:Colors.black),
	  			const SizedBox(height:12),
	  			Text(name,style:TextStyle(color:selected?Colors.white:Colors.black,fontWeight:FontWeight.bold,fontSize:21)),
	  		],
	  	),
	  ),
  );
}