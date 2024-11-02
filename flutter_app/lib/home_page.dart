import 'package:flutter/material.dart';
import 'api_service.dart'; 
import 'place.dart'; 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Place>> futureDestinations;

  @override
  void initState() {
    super.initState();
    futureDestinations = ApiService.fetchPlaces(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi Guy!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Where are you going next?", style: TextStyle(fontSize: 16)),
          ],
        ),
        backgroundColor: Colors.purple,
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search your destination",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryButton(icon: Icons.hotel, label: "Hotels"),
                CategoryButton(icon: Icons.flight, label: "Flights"),
                CategoryButton(icon: Icons.place, label: "All"),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Popular Destinations",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Place>>(
                future: futureDestinations,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Failed to load destinations'));
                  } else {
                    final destinations = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 3 / 4,
                      ),
                      itemCount: destinations.length,
                      itemBuilder: (context, index) {
                        final destination = destinations[index];
                        return DestinationCard(destination: destination);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "SEARCH"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "PROFILE"),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;

  CategoryButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.purple),
        Text(label),
      ],
    );
  }
}

class DestinationCard extends StatelessWidget {
  final Place destination;

  DestinationCard({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(destination.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                destination.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.black45,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 16),
                  Text(destination.description.toString(), style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Icon(Icons.favorite, color: Colors.red),
        ),
      ],
    );
  }
}
