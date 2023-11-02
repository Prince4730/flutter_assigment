String getFirstTwoLetters(String inputString) {
  if (inputString.length >= 2) {
    return inputString.substring(0, 2).toUpperCase();
  } else {
    return inputString.toUpperCase();
  }
}