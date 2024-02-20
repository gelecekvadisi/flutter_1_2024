import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DialogPage"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _showAlert();
              },
              child: Text("Uyarı ver"),
            ),
            Theme(
              data: ThemeData(
                  /* dialogBackgroundColor: Colors.blue,
                dialogTheme: DialogTheme(
                  backgroundColor: Colors.blue,
                ), */
                  ),
              child: ElevatedButton(
                onPressed: () {
                  _selectDate();
                },
                child: Text("Tarih Seç"),
              ),
            ),
            Text(_getSelectedDateText()),
          ],
        ),
      ),
    );
  }

  String _getSelectedDateText() {
    if (selectedDate == null) {
      return "Tarih seçilmedi.";
    } else {
      return DateFormat(DateFormat.YEAR_MONTH_DAY  /* "dd MMMM yyyy" */, "tr").format(selectedDate!);
      
      // return selectedDate;
    }
  }

  _showAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Uyarı"),
          content: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dignissim efficitur leo, at consectetur nisl ultricies a. Nunc eu maximus nisl, et egestas magna. Aenean gravida mauris ut mauris semper egestas. Praesent pharetra lorem lorem, id condimentum ipsum posuere in. Praesent ultrices magna magna, nec mollis risus ornare eu. Mauris sit amet dui elit. Vestibulum tempus tincidunt bibendum."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Tamam")),
          ],
        );
      },
    );
  }

  void _selectDate() async {
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    selectedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      // locale: Locale("tr", "TR"),
      initialDate: DateTime(2024, 2, 15),
      // barrierColor: Colors.green,
    );

    setState(() {});

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tarih alınamadı.")),
      );
    }
  }
}
