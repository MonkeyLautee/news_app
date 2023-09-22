import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
	final String image;
	final String title;
	final String description;
	final bool bookmarked;
  const NewsCard({required this.image,required this.title,required this.description,required this.bookmarked,Key? key}):super(key:key);
  @override
  Widget build(BuildContext context)=>Stack(
  	children: [
  		Center(
  			child: Container(
	  			width: MediaQuery.of(context).size.width*0.9,
	      	height: 300.0,
			  	decoration: BoxDecoration(
			  		color:Colors.white,
				    borderRadius: BorderRadius.circular(23.0),
				  ),
				  child:Column(
				  	children: [
				  		Expanded(
				  			child: ClipRRect(
								  borderRadius: const BorderRadius.vertical(
								    top: Radius.circular(23.0),
								    bottom: Radius.zero,
								  ),
								  child: Image.network(
									  image,
									  width: double.infinity,
									  fit: BoxFit.cover,
									  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
									    if (loadingProgress == null) {
									      return child;
									    } else {
									      return Center(
									        child: CircularProgressIndicator(
									          value: loadingProgress.expectedTotalBytes != null
									              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1.0)
									              : null,
									        ),
									      );
									    }
									  },
									  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
									    return Image.asset(
									      'assets/no-image.jpg',
									      width: double.infinity,
									      fit: BoxFit.cover,
									    );
									  },
									),
								),
				  		),
				  		Expanded(
				  			child: Align(
				  				alignment: Alignment.topLeft,
				  				child: Padding(
				  					padding: const EdgeInsets.only(left:10,top:10),
				  					child: Column(
						  				crossAxisAlignment: CrossAxisAlignment.start,
						  				children: [
						  					Text(title,style:Theme.of(context).textTheme.headlineSmall),
						  					const SizedBox(height:7),
						  					Text(description,style:Theme.of(context).textTheme.bodyMedium),
						  				],
						  			),
				  				),
				  			),
				  		),
				  	],
				  ),
			  ),
  		),
		  Positioned(
	      bottom: 0,
	      right: 0,
	      child: Transform.translate(
	      	offset: const Offset(10,10),
	      	child: Container(
  	        width: 72,
  	        height: 72,
  				  decoration: BoxDecoration(
  				  	color: Colors.black,
  				    shape: BoxShape.circle,
  				    border: Border.all(
  				      color: const Color.fromRGBO(230,230,230,1),
  				      width: 10,
  				    ),
  				  ),
  				  child: Center(
  				  	child: IconButton(
  				  		onPressed: (){},
  				  		icon: Icon(bookmarked?Icons.bookmark:Icons.bookmark_border,color:Colors.white),
  				  	)
  				  ),
  	      ),
	      ),
	    ),
  	],
  );
}