import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("This is the first page")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text Box with no label text
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type something...", // Only hint remains
              ),
            ),
            SizedBox(height: 50), // Space between widgets

            // First two images in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "assets/images/batman.webp",
                  width: 300,
                  height: 300,
                ),
                SizedBox(width: 10), // Space between images
                Image.network(
                  "assets/images/Flash.webp",
                  width: 300,
                  height: 300,
                ),
              ],
            ),

            SizedBox(height: 10), // Space between row and the next image

            // Third image centered below
            Center(
              child: Image.network(
                "assets/images/Spiderman.png",
                width: 300,
                height: 300,
              ),
            ),

           SizedBox(height: 50), // Space before the button

            // Button to navigate to Next Page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              child: Text("Go to Next Page"),
            ),
          ],
        ),
      ),
    );
  }
}

// Second Screen (Next Page) with Slider
class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  double _sliderValue = -75; // Initial value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Next Page with Slider")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Slider",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Slider Widget
            Slider(
              value: _sliderValue,
              min: -75,
              max: 275,
              divisions: (275 - (-75)) ~/ 25, // Steps of 25
              label: _sliderValue.toString(),
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),

            SizedBox(height: 20),

            // Display current slider value
            Text(
              "Current Value: $_sliderValue",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

           SizedBox(height: 100), // Space before the image

            // Image below the slider
            Image.asset(
              "assets/images/ironman.webp", // Make sure you have this image in your assets folder
              width: 300,
              height: 300,
            ),

             SizedBox(height: 100), // Space before button

             // Button to navigate to Third Page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdPage()),
                );
              },
              child: Text("Go to Third Page"),
            ),
          ],
        ),
      ),
    );
  }
}
class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  List<String> _items = []; // List to store items
  TextEditingController _itemController = TextEditingController(); // Controller for TextField

  // Method to add item to the list
  void _addItem() {
    if (_itemController.text.isNotEmpty) {
      setState(() {
        _items.add(_itemController.text); // Add text to list
        _itemController.clear(); // Clear input field
      });
    }
  }

  // Method to remove an item from the list
  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index); // Remove item at specific index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Third Page - List of Items')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // TextField to enter items
            TextField(
              controller: _itemController,
              decoration: InputDecoration(
                labelText: 'Enter item to add',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            // Button to add item to the list
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Add Item'),
            ),
            SizedBox(height: 20),

            // Display list of items dynamically
            Expanded(
              child: _items.isEmpty
                  ? Center(child: Text("No items added yet!")) // Show message if empty
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(_items[index]),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeItem(index), // Remove item
                            ),
                          ),
                        );
                      },
                    ),
            ),

            SizedBox(height: 100), // Space before image

            // Image below the list, centered
            Center(
              child: Image.asset(
                "assets/images/mm.jpg", // Ensure this image is inside assets folder
                width: 400,
                height: 400,
              ),
            ),

            SizedBox(height: 100), // Space before button

            // Button to go back to First Page
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (route) => false, // Removes all previous pages from stack
                );
              },
              child: Text("Go to First Page"),
            ),
          ],
        ),
      ),
    );
  }
}