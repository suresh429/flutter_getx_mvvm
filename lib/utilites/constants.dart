String calculateTimeLeft(int startDate, int dueDate) {
  // Get the current time
  final currentTime = DateTime.now().millisecondsSinceEpoch;

  // Calculate the remaining time in milliseconds
  final timeLeft = dueDate - currentTime;

  if (timeLeft > 0) {
    // Convert milliseconds to Duration
    final duration = Duration(milliseconds: timeLeft);

    // Get days, hours, and minutes left
    final daysLeft = duration.inDays;
    final hoursLeft = duration.inHours % 24;
    final minutesLeft = duration.inMinutes % 60;

    if (daysLeft > 1) {
      return "$daysLeft days left";
    } else if (daysLeft == 1) {
      return "1 day left";
    } else if (hoursLeft >= 1) {
      return "$hoursLeft hours left";
    } else {
      return "$minutesLeft minutes left";
    }
  } else {
    return "0 days left"; // or "Expired" if you prefer
  }
}
