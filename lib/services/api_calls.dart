import 'package:http/http.dart' as http;
import 'dart:convert';

class APICalls {
	
	static final String newsApiKey = 'c7809e717fba4b8d8b0b8bcc3358ecee';
	static final String newsApiUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$newsApiKey';
	static final String weatherApiKey = '4ae172eec406442254831e941a1a7e22';
	
	static Future<List?> getNews()async{
		try {
	    final response = await http.get(Uri.parse(newsApiUrl));
	    if (response.statusCode == 200) {
	      final Map<String, dynamic> data = json.decode(response.body);
	      if (data.containsKey('articles')) {
	        return data['articles'];
	      } else {
	        print('No articles found in the response.');
	        return <Map<String,dynamic>>[];
	      }
	    } else {
	      print('Error: ${response.statusCode}');
	      return null;
	    }
	  } catch (error) {
	    print('Error: $error');
	    return null;
	  }
	}

	static Future<String?> getWeather(String location) async {
	  final apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$weatherApiKey';
	  try {
	    final response = await http.get(Uri.parse(apiUrl));
	    if (response.statusCode == 200) {
	      final Map<String, dynamic> data = json.decode(response.body);
	      return data['weather'][0]['description'];
	    } else {
	      print('Error: ${response.statusCode}');
	    }
	  } catch (error) {
	    print('Error: $error');
	  }
	}

}