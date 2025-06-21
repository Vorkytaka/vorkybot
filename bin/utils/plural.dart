String getRussianPluralForm(
    int number, String form1, String form2, String form5) {
  final mod10 = number % 10;
  final mod100 = number % 100;

  if (mod10 == 1 && mod100 != 11) {
    return form1;
  } else if ((mod10 >= 2 && mod10 <= 4) && !(mod100 >= 12 && mod100 <= 14)) {
    return form2;
  } else {
    return form5;
  }
}
