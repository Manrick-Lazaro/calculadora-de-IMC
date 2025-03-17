import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String imcInfo = "Informe seus dados.";

  void _resetFields() {
    setState(() {
      heightController.clear();
      weightController.clear();
      imcInfo = "Informe seus dados.";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;

    double imc = weight / (height * height);

    setState(() {
      if (imc < 18.6) {
        imcInfo = "Abaixo do peso [${imc.toStringAsPrecision(2)}]";
      } else if (imc > 18.6 && imc < 24.9) {
        imcInfo = "Peso ideal [${imc.toStringAsPrecision(2)}]";
      } else if (imc > 24.9 && imc < 29.9) {
        imcInfo = "Levemente acima do peso [${imc.toStringAsPrecision(2)}]";
      } else if (imc > 29.9 && imc < 34.9) {
        imcInfo = "Obesidade grau I [${imc.toStringAsPrecision(2)}]";
      } else if (imc > 34.9 && imc < 39.9) {
        imcInfo = "Obesidade grau II [${imc.toStringAsPrecision(2)}]";
      } else if (imc > 39.9) {
        imcInfo = "Obesidade grau I [${imc.toStringAsPrecision(2)}]";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculadora de IMC',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outlined, size: 120, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text('Peso (kg)'),
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 20),
                controller: weightController,
                validator: (value) {
                  if(value!.isEmpty) {
                    return "O peso deve se informado.";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text('Altura (cm)'),
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 20),
                controller: heightController,
                validator: (value) {
                  if(value!.isEmpty) {
                    return "A altura deve se informada.";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      _calculate;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(
                    'Calcular',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Text(
                imcInfo,
                style: TextStyle(fontSize: 20, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
