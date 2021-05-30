import 'package:flutter/material.dart';
import 'package:flutter_animals_advanced/data/api_service.dart';
import 'package:flutter_animals_advanced/models/cat.dart';
import 'package:flutter_animals_advanced/screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future? cats;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    populateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat List'),
      ),
      body: _makeBody(),
    );
  }

  Widget _makeBody() {
    return FutureBuilder(
        future: cats,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Cat> catData = snapshot.data as List<Cat>;
            return ListView.builder(
              itemCount: catData.length,
              itemBuilder: (context, index) {
                return Card(
                  semanticContainer: true,
                  elevation: 5,
                  child: ListTile(
                    title: Text(catData[index].name),
                    minLeadingWidth: 50,
                    trailing: FutureBuilder(
                      future:
                          apiService.getImageUrlByBreedId(catData[index].id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          String url = snapshot.data as String;
                          return Image.network(
                            url,
                            height: 100,
                            width: 100,
                          ); // image is ready
                        } else {
                          return Container(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ); // placeholder
                        }
                      },
                    ),
                    onTap: () => showDetails(context, catData[index]),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          return Center(child: CircularProgressIndicator());
        });
  }

  void populateList() {
    cats = apiService.getAllCats();
  }

  void showDetails(BuildContext context, Cat catData) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return DetailsScreen(cat: catData);
        },
      ),
    );
  }
}
