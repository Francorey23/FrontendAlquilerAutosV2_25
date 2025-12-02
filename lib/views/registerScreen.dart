import 'package:flutter/material.dart';
import 'package:flutter_application_6/views/loginScreen.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  // Colores coherentes con LoginScreen
  final Color fondo = const Color(0xFFAFDDFF);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color campos = const Color(0xFFFFECDB);
  final Color boton = const Color(0xFFFF9149);
  final Color texto = const Color(0xFF222222);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            // Icono en la parte superior
            Icon(
              Icons.person_add,
              size: 80,
              color: encabezado,
            ),
            const SizedBox(height: 16.0),

            // Texto "Empecemos"
            Text(
              "Empecemos",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: encabezado,
              ),
            ),
            const SizedBox(height: 8.0),

            // Texto "Crear una nueva cuenta"
            Text(
              "Crear una nueva cuenta",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: texto.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 32.0),

            // Campo de nombre completo
            TextField(
              style: TextStyle(color: texto),
              decoration: InputDecoration(
                filled: true,
                fillColor: campos,
                labelText: 'Nombre completo',
                labelStyle: TextStyle(color: texto),
                prefixIcon: Icon(Icons.person, color: encabezado),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Campo de correo electrónico
            TextField(
              style: TextStyle(color: texto),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: campos,
                labelText: 'Correo electrónico',
                labelStyle: TextStyle(color: texto),
                prefixIcon: Icon(Icons.email, color: encabezado),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Campo de contraseña
            TextField(
              obscureText: true,
              style: TextStyle(color: texto),
              decoration: InputDecoration(
                filled: true,
                fillColor: campos,
                labelText: 'Contraseña',
                labelStyle: TextStyle(color: texto),
                prefixIcon: Icon(Icons.lock, color: encabezado),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Campo de confirmación de contraseña
            TextField(
              obscureText: true,
              style: TextStyle(color: texto),
              decoration: InputDecoration(
                filled: true,
                fillColor: campos,
                labelText: 'Confirmar contraseña',
                labelStyle: TextStyle(color: texto),
                prefixIcon: Icon(Icons.lock, color: encabezado),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 32.0),

            // Botón de registro
            ElevatedButton(
              onPressed: () {
                // Acción para el registro
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: boton,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                'Registrarse',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16.0),

            // Texto para iniciar sesión
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("¿Ya tienes una cuenta? ",
                    style: TextStyle(color: texto)),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                  },
                  child: Text(
                    "Iniciar sesión",
                    style: TextStyle(
                      color: encabezado,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
