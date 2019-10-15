import processing.serial.*;
Serial MiSerial;
int Valor = 0;
PrintWriter output;

void setup() {
  size (400, 400);
  String NombrePuerto = Serial.list()[0]; //Puerto en el que se conecta Arduino
  MiSerial = new Serial(this, NombrePuerto, 9600);
  output = createWriter("Datos_Sensor_Temperatura.txt"); // Aqui se crea el bloc de notas
  
}

void draw() {
  int ValorRojo = int (map(Valor, 0, 30, 0, 255));
  color ColorFondo = color(ValorRojo, 0, 0);
  background(ColorFondo);

  if (MiSerial.available() < 100) {
    String Texto = MiSerial.readStringUntil('\n');
    if (Texto != null) {
      Valor = int(trim(Texto));
    }
    println("Grados C:",Valor);
  }
  textSize(20);
  text("Temperatura= ",20,40);
  text(Valor,165,40);
  text(" °C",185,40);
  
  output.print(Valor + " °C "); // Y aqui se le envian los datos a almacenas
  output.print(hour() + ":");
  output.print(minute() + ":");
  output.print(second());
  output.println("");
}
