// Global variables
import "package:classroom_clarity_app/bluetooth_handler.dart";

late final BLEHandler bleHandler;

//settings
double max_font_size = 3;
double min_font_size = 1;
double font_size = 15;
bool silent_mode = false;

//other data
String name = 'Student';
bool anonymous = false;

//password handling
bool studentAuthenticated = false;
bool instructorAuthenticated = false;
String connectionText = "";
String connectionText2 = "";
//Sent Data
String question = "";
int curr_engagementLevel = 5;
int prev_engagementLevel = 0;

