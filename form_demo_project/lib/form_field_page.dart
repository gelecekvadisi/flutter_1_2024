import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class FormFieldPage extends StatelessWidget {
  FormFieldPage({super.key});

  String userName = "", email = "", password = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form yapıları"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Kullanıcı Adı",
                  errorStyle: TextStyle(color: Colors.orange),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.orange,
                  )),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.orange,
                  )),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.length < 4) {
                    return "Kullanıcı adı en az 4 karakter olmalıdır.";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  userName = value!;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "E-Mail",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // bool isValidate = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value!);
                  bool isValidate = EmailValidator.validate(value!);


                  if (value.isEmpty) {
                    return "E-Mail alanı boş geçilemez.";
                  } else if (!isValidate) {
                    return "Lütfen geçerli bir mail adresi giriniz.";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Parola", border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.length < 6) {
                    return "Parolanız en az 6 karakter uzunluğunda olmalıdır.";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () => saveForm(context), child: Text("Kaydet")),
            ],
          ),
        ),
      ),
    );
  }

  void saveForm(BuildContext context) {
    bool isValidate = _formKey.currentState!.validate();
    if (isValidate) {
      _formKey.currentState!.save();
      _formKey.currentState!.reset();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "KullanıcıAdı: $userName\nE-Mail: $email\nParola: $password"),
        ),
      );
    }
  }
}
