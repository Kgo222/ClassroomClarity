// Global variables
import "package:classroom_clarity_app/bluetooth_handler.dart";

late final BLEHandler bleHandler;

//settings
double max_font_size = 20;
double min_font_size = 10;
double font_size = 15;
bool silent_mode = false;

//other data
String name = 'Student';
String hub = "";

//Sent Data
String question = "";
int engagementLevel = 10;