String fullNameToFirstName(String fullName) {
  if (fullName.indexOf(" ") == -1) return fullName;
  return fullName.substring(0, fullName.indexOf(" ")).trim();
}

String fullNameToLastName(String fullName) {
  if (fullName.indexOf(" ") == -1) return "";
  return fullName.substring(fullName.indexOf(" "), fullName.length).trim();
}

String firstNameAndLastNameToFullName(String firstName, String lastName) {
  if (lastName == "") return firstName;
  return firstName + lastName;
}
