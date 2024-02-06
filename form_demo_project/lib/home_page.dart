import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        _emailController.text = "demo@furkan.com";
      }, child: Icon(Icons.change_circle)),
        appBar: AppBar(
          title: const Text('Field Widgets'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              /* Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: TextField()),
                  Expanded(child: TextField()),
                ],
              ), */
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  maxLines: 1,
                  // maxLength: 15,
                  onChanged: (value) {
                    setState(() {
                      
                    });
                    debugPrint("onChanged: $value");
                  },
                  onSubmitted: (value) {
                    debugPrint("OnSubmitted: $value");
                  },
                  // cursorColor: Colors.red,
                  decoration: InputDecoration(
                    labelText: "E-Mail",
                    hintText: "Buraya kurumsal email adresinizi yazın.",
                    // hintStyle: TextStyle(color: Colors.red),
                    // icon: Icon(Icons.mail),
                    prefixIcon: Icon(Icons.mail_outline),
                    // suffixIcon: Icon(Icons.dark_mode),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    // filled: true,
                    // fillColor: Colors.amber,
                  ),
                ),
              ),
              Text(_emailController.text, 
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
              TextField(
                textInputAction: TextInputAction.next
              ),
            ],
          ),
        ),
      );
  }
}