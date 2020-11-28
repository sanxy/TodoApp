import 'package:intl/intl.dart';

String dateFormatted() {
        var date = DateTime.now();
        var formatter = DateFormat("EEE, MMM d, ''yy");
        String formattedDate = formatter.format(date);
        return formattedDate;
}