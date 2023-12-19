import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  AuthService authService =
      AuthService('https://hffckdm7-8000.brs.devtunnels.ms');
  Map<String, dynamic>? userInfo;

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoController = TextEditingController();
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    loadUserInfo();
    initializeDateFormatting('es');
  }

  Future<void> loadUserInfo() async {
    try {
      Map<String, dynamic> info =
          await authService.getUserInfo('Estebanparedes017@gmail.com');
      setState(() {
        userInfo = info;
        _nombreController.text = userInfo?['nombre'] ?? '';
        _apellidoController.text = userInfo?['apellido'] ?? '';
      });
    } catch (error) {
      print("Error al cargar la información del usuario: $error");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final snackBar = SnackBar(
      content: Text('Se guardaron los datos correctamente'),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {
      userInfo?['nombre'] = _nombreController.text;
      userInfo?['apellido'] = _apellidoController.text;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 224, 243, 1),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'logout',
                child: Text('Cerrar Sesión'),
              ),
            ],
          ),
        ],
        title: Container(
          height: 20,
          child: Image.asset('assets/logo.png'),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          userInfo != null
              ? buildUserInfoWidget(userInfo!)
              : CircularProgressIndicator(),
          buildUserProfile(),
          buildNotifications(),
          buildTrainingTab(), // Nueva pestaña de entrenamientos
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

    Widget buildBottomNavigationBar() {
    return Container(
      color: Color.fromRGBO(18, 224, 243, 1),
      child: TabBar(
        controller: _tabController,
        tabs: [
          buildTab('Inicio', Icons.home),
          buildTab('Perfil', Icons.person),
          buildTab('Notificaciones', Icons.notifications),
          buildTab('Entrenamientos', Icons.calendar_today),
        ],
        onTap: (index) {
          if (index == 1 && !_editing) {
            setState(() {
              _editing = true;
            });
          }
        },
      ),
    );
  }

  // Nuevo método para construir pestañas
  Widget buildTab(String text, IconData icon) {
    return Tab(
      child: Column(
        children: [
          Icon(icon),
          SizedBox(height: 4), // Espaciador entre el ícono y el texto
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 9), // Tamaño del texto
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserInfoWidget(Map<String, dynamic> userInfo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                margin: EdgeInsets.only(bottom: 20),
                child: Image.asset('assets/logo.png'),
              ),
              Text(
                '¡Bienvenido, ${userInfo['nombre']}!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(height: 20),
              buildInfoRow(Icons.assignment, 'Plan: ${userInfo['plan']}',
                  Color.fromARGB(255, 0, 0, 0)),
              SizedBox(height: 20),
              buildInfoRow(
                  Icons.calendar_today,
                  'Fecha de inicio: ${userInfo['fecha_inicio']}',
                  const Color.fromARGB(255, 0, 0, 0)),
              buildInfoRow(
                  Icons.calendar_today,
                  'Fecha de fin: ${userInfo['fecha_termino']}',
                  const Color.fromARGB(255, 0, 0, 0)),
              SizedBox(height: 20),
              buildInfoRow(Icons.timer,
                  'Días restantes: ${userInfo['dias_restantes']}',
                  Color.fromARGB(255, 0, 0, 0)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String text, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }

  Widget buildUserProfile() {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.5,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_editing)
                Column(
                  children: [
                    Text(
                      'Editar Perfil',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _nombreController,
                      decoration: InputDecoration(labelText: 'Nombre'),
                    ),
                    TextField(
                      controller: _apellidoController,
                      decoration: InputDecoration(labelText: 'Apellido'),
                    ),
                    SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () async {
                        await _saveChanges();
                        setState(() {
                          _editing = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                      ),
                      child: Text('Guardar Cambios'),
                    ),
                  ],
                ),
              if (!_editing && userInfo != null)
                Column(
                  children: [
                    Text(
                      'Se guardaron los datos correctamente',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotifications() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          SizedBox(height: 20),
          buildNotificationCard(1, 'Promoción para renovar plan', 'Descripción corta'),
          SizedBox(height: 10),
          buildNotificationCard(2, 'Recuerda renovar tu plan', 'Descripción corta'),
          SizedBox(height: 10),
          buildNotificationCard(3, 'Tu sesion de entrenamiento a cambiado', 'Descripción corta'),
        ],
      ),
    );
  }

  Widget buildNotificationCard(int index, String title, String description) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notificación $index',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Fecha: ${DateTime.now().toLocal()}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }

    Widget buildTrainingTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Agendar entrenamiento',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            SizedBox(height: 20),
            CalendarWidget(),
          ],
        ),
      ),
    );
  }

  // ... (Otros métodos y widgets)
}

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'es_ES', // Establece el idioma a español
      calendarFormat: _calendarFormat,
      focusedDay: _focusedDay,
      firstDay: DateTime(2021),
      lastDay: DateTime(2030),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay; // Actualiza `_focusedDay` aquí también
        });
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
    );
  }
}
  