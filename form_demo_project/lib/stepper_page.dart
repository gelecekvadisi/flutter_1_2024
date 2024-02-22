import 'package:flutter/material.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  int currentStep = 0;
  ScrollController _scrollController = ScrollController();

  

  @override
  Widget build(BuildContext context) {
    List<Step> stepList = [
    Step(
      isActive: currentStep == 0,
      title: const Text("Ad Soyad"),
      content: TextFormField(
        decoration: const InputDecoration(
          label: Text("Ad Soyad"),
        ),
      ),
    ),
    Step(
      isActive: currentStep == 1,
      title: const Text("E-Posta"),
      content: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          label: Text("E-Posta"),
        ),
      ),
    ),
    Step(
      title: const Text("Adres"),
      state: StepState.complete,
      isActive: currentStep == 2,
      // subtitle: Text("Şahsınanıza ait adres bilgilerini burada belirtmeniz gerekiyor."),
      content: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              label: Text("İl"),
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              label: Text("İlçe"),
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              label: Text("Mahalle"),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Sokak"),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Daire No"),
            ),
          ),
        ],
      ),
    ),
  ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stepper Page"),
      ),
      body: Stepper(
        steps: stepList,
        controller: _scrollController,
        currentStep: currentStep,
        type: StepperType.horizontal,
        physics: BouncingScrollPhysics(),
        onStepTapped: (index) {
          setState(() {
            currentStep = index;
          });
        },
        onStepContinue: () {
          if (currentStep != (stepList.length - 1)) {
            setState(() {
              currentStep++;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Son adımdasınız."),
              ),
            );
          }
        },
        onStepCancel: () {
          if (currentStep != 0) {
            setState(() {
              currentStep--;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("İlk adımdasınız."),
              ),
            );
          }
        },
      ),
    );
  }
}
