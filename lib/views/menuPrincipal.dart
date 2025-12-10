import 'package:flutter/material.dart';
import 'package:flutter_application_6/controllers/autosController.dart';
import 'package:flutter_application_6/views/detalleVehiculo.dart';
import 'package:flutter_application_6/views/menuDrawerPerfil.dart';

class MenuPrincipal extends StatefulWidget {
  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  // 🎨 Paleta unificada (misma del login/registro)
  final Color fondo = const Color(0xFFAFDDFF);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color campos = const Color(0xFFFFECDB);
  final Color boton = const Color(0xFFFF9149);
  final Color texto = const Color(0xFF222222);

  // 🔗 Controlador que consume la API
  final AutosService autosController = AutosService();

  // 📦 Lista de autos que viene del backend
  List<Map<String, dynamic>> listaDeAutos = [];

  // ⏳ Indicador de carga
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarAutos();
  }

  void cargarAutos() async {
    try {
      final autos = await autosController.obtenerAutosDisponibles();

      if (!mounted) return; // 👈 importante

      setState(() {
        listaDeAutos = autos;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return; // 👈 también aquí

      setState(() {
        isLoading = false;
      });
      print('Error al cargar autos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      drawer: MenuDrawerPerfil(),
      appBar: AppBar(
        title: const Text('Alquiler de Vehículos'),
        backgroundColor: encabezado,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔎 Cuadro de búsqueda con icono
            TextField(
              style: TextStyle(color: texto),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: encabezado),
                hintText: 'Buscar vehículo',
                hintStyle: TextStyle(color: texto.withOpacity(0.7)),
                labelStyle: TextStyle(color: texto),
                filled: true,
                fillColor: campos,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            //  Lista de vehículos
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : listaDeAutos.isEmpty
                      ? const Center(
                          child: Text('No hay vehículos disponibles.'))
                      : ListView.builder(
                          itemCount: listaDeAutos.length,
                          itemBuilder: (BuildContext context, int index) {
                            final auto = listaDeAutos[index];

                            final String imageUrl =
                                (auto['imageUrl'] ?? '') as String;
                            final String marca =
                                (auto['marca'] ?? '') as String;
                            final String modelo =
                                (auto['modelo'] ?? '') as String;

                            // anio puede venir como int o String
                            final dynamic anioRaw = auto['anio'];
                            final int anio = anioRaw is int
                                ? anioRaw
                                : int.tryParse(anioRaw.toString()) ?? 0;
                            final String anioTexto = anioRaw?.toString() ?? '';

                            // precio numérico
                            final num precioNum = (auto['precio'] ?? 0) as num;
                            final double precio = precioNum.toDouble();

                            // disponibilidad puede venir como bool o 0/1
                            final dynamic dispRaw = auto['disponibilidad'];
                            final bool disponibilidad =
                                dispRaw is bool ? dispRaw : dispRaw == 1;

                            return Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUrl.isNotEmpty
                                        ? imageUrl
                                        : 'https://picsum.photos/330/200',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.network(
                                        'https://picsum.photos/330/200',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                                title: Text(
                                  '$marca $modelo',
                                  style: TextStyle(
                                    color: texto,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  'Año: $anioTexto  •  Precio: \$${precio.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: texto.withOpacity(0.8),
                                  ),
                                ),
                                trailing:
                                    Icon(Icons.arrow_forward_ios, color: boton),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetalleVehiculoScreen(
                                        imageUrl: imageUrl,
                                        marca: marca,
                                        modelo: modelo,
                                        anio: anio,
                                        disponibilidad: disponibilidad,
                                        precio: precio,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: boton,
        unselectedItemColor: texto.withOpacity(0.6),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car), label: 'Alquiler'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Usuario'),
        ],
      ),
    );
  }
}
