import 'package:calculadora/Calcular.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Segundos de su vida.',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        foregroundColor: Colors.amber,
        backgroundColor: Color.fromRGBO(000, 000, 000, 100),
      ),
      body: const CalculateSeconds(),
    );
  }
}

class CalculateSeconds extends StatefulWidget {
  const CalculateSeconds({
    Key? key,
  }) : super(key: key);

  @override
  State<CalculateSeconds> createState() => _CalculateSecondsState();
}

class _CalculateSecondsState extends State<CalculateSeconds> {
  bool correctdate = false;
  String? value;
  DateTime? dateBorn;
  TimeOfDay? horaBorn;
  bool? estadoSeg = true;
  bool? estadoMin = false;
  bool? estadoHora = false;
  bool? estadoDia = false;

  textWithStyle(Title) {
    return Text(
      Title,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontFamily: "Consolas", fontSize: 20, color: Colors.black),
    );
  }

  @override
  void initState() {
    super.initState();
    dateBorn = DateTime.now();
    horaBorn = TimeOfDay.now();
  }

  estadoNow(estado, title) {
    setState(() {
      if (title.equals("Días")) {
        estadoDia = estado;
      }
    });
  }

  buildCheckBox(
    title,
    estado,
  ) {
    return;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(children: [
          const SizedBox(
            width: 10,
            height: 10,
          ),
          textWithStyle("Ingresa tu fecha de nacimiento"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  datetext,
                  style: TextStyle(
                    color: Colors.lightBlue.shade600,
                    fontSize: 25.0,
                  ),
                ),
                IconButton(
                    onPressed: () => pickDate(context),
                    icon: const Icon(
                      Icons.calendar_today,
                      size: 30,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
            width: 10,
          ),
          textWithStyle("Ingresa la hora de tu nacimiento"),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    timetext,
                    style: TextStyle(
                      color: Colors.lightBlue.shade600,
                      fontSize: 25.0,
                    ),
                  ),
                  IconButton(
                      onPressed: () => pickTime(context),
                      icon: const Icon(
                        CupertinoIcons.clock,
                        size: 30,
                      )),
                ],
              )),
          ElevatedButton(
              child: const Text(
                'Calcular',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                final date2 = DateTime.now();
                print(date2);
                DateTime fecha1 = DateTime.parse(
                    "${formatoFecha(dateBorn)} ${formatoHora(horaBorn)}:00");
                bool error = false;
                if (date2.difference(fecha1).inDays < 2) {
                  error = true;
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CalculadoraVida(
                            fecha1,
                            date2,
                            estadoSeg,
                            estadoMin,
                            estadoHora,
                            estadoDia,
                            error)));
              }),
          const SizedBox(
            height: 20,
            width: 20,
          ),
          Row(children: [
            const SizedBox(
              height: 20,
              width: 20,
            ),
            Checkbox(
                value: estadoSeg,
                onChanged: (value) {
                  setState(() {
                    estadoSeg = value;
                  });
                }),
            textWithStyle("En segundos")
          ]),
          Row(children: [
            const SizedBox(
              height: 20,
              width: 20,
            ),
            Checkbox(
                value: estadoMin,
                onChanged: (value) {
                  setState(() {
                    estadoMin = value;
                  });
                }),
            textWithStyle("En minutos")
          ]),
          Row(children: [
            const SizedBox(
              height: 20,
              width: 20,
            ),
            Checkbox(
                value: estadoHora,
                onChanged: (value) {
                  setState(() {
                    estadoHora = value;
                  });
                }),
            textWithStyle("En horas")
          ]),
          Row(
            children: [
              const SizedBox(
                height: 20,
                width: 20,
              ),
              Checkbox(
                  value: estadoDia,
                  onChanged: (value) {
                    setState(() {
                      estadoDia = value;
                    });
                  }),
              textWithStyle("En días")
            ],
          ),
        ]),
      ),
    ));
  }

  String get datetext {
    if (dateBorn == null) {
      return ('00/00/0000');
    } else {
      correctdate = true;
      return formatoFecha(dateBorn);
    }
  }

  formatoFecha(fecha) {
    String year = dateBorn!.year.toString();
    String mes = dateBorn!.month.toString();
    if (mes.length == 1) {
      var aux = mes;
      mes = "0" + aux;
    }
    String dia = dateBorn!.day.toString();
    if (dia.length == 1) {
      var aux = dia;
      dia = "0" + aux;
    }
    return "$year-$mes-$dia";
  }

  formatoHora(hora) {
    String hora = horaBorn!.hour.toString();
    if (hora.length == 1) {
      var aux = hora;
      hora = "0" + aux;
    }
    String min = horaBorn!.minute.toString();
    if (min.length == 1) {
      var aux = min;
      min = "0" + aux;
    }

    return "$hora:$min";
  }

  String get timetext {
    if (horaBorn == null) {
      return ('00:00');
    } else {
      correctdate = true;
      return formatoHora(horaBorn);
    }
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime(DateTime.now().year + 1));

    if (newDate == null) return;
    setState(() => dateBorn = newDate);
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay.now();
    final newTime =
        await showTimePicker(context: context, initialTime: initialTime);

    if (newTime == null) return;
    setState(() => horaBorn = newTime);
  }
}
