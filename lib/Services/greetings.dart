
String getGreeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;
  if (hour >= 3 && hour < 12) {
    return "Good Morning";
  } else if (hour >= 12 && hour < 18) {
    return "Good Afternoon";
  } else {
    return "Good Evening";
  }
}