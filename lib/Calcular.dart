import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CalculadoraVida extends StatelessWidget {
  late var differenceSeg;
  late var differenceHora;
  late var differenceDay;
  late var differenceMin;
  String etapa = "";

  late bool seg, min, hora, dia, error;
  CalculadoraVida(fechaInicio, fechaFin, seg, min, hora, dia, error) {
    this.seg = seg;
    this.min = min;
    this.hora = hora;
    this.dia = dia;
    this.error = error;
    differenceSeg = fechaFin.difference(fechaInicio).inSeconds;
    differenceHora = fechaFin.difference(fechaInicio).inHours;
    differenceDay = fechaFin.difference(fechaInicio).inDays;
    differenceMin = fechaFin.difference(fechaInicio).inMinutes;
    QueEdadTiene();
  }

  QueEdadTiene() {
    //60 year
    if (differenceSeg < {31536000 * 60}) {
      etapa = "abuelo";
      //35 year
      if (differenceSeg < {31536000 * 35}) {
        etapa = "adulto";
        //22 year
        if (differenceSeg < {31536000 * 22}) {
          etapa = "joven";
          //11 years
          if (differenceSeg < {31536000 * 11}) {
            etapa = "boy";
            //3 year
            if (differenceSeg < {31536000 * 3}) {
              etapa = "baby";
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            " Tu estancia en la tierra es de ",
            textAlign: TextAlign.center,
          )),
          backgroundColor: Color.fromRGBO(000, 000, 000, 90),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: [
            buildEspacio(),
            seg
                ? textWithStyle("" + differenceSeg.toString() + " segundos")
                : Container(),
            buildEspacio(),
            min
                ? textWithStyle("" + differenceMin.toString() + " minutos")
                : Container(),
            buildEspacio(),
            hora
                ? textWithStyle("" + differenceHora.toString() + " horas")
                : Container(),
            buildEspacio(),
            dia
                ? textWithStyle("" + differenceDay.toString() + " días")
                : Container(),
            buildEspacio(),
            error
                ? textWithStyle("No creo que seas tan joven, intenta de nuevo")
                : Container(),
            Image(
              image: AssetImage("assets/images/$etapa.jpg"),
            )
          ],
        ));
  }

  buildEspacio() {
    return const SizedBox(
      height: 20,
      width: 20,
    );
  }

  textWithStyle(Title) {
    return Text(
      Title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: "Consolas",
        fontSize: 30,
        color: Colors.black,
      ),
    );
  }
}
