class Veterinary {
  final String name;
  final String address;
  final String image;
  final String contact;

  const Veterinary({
    required this.name,
    required this.address,
    required this.image,
    required this.contact,
  });
}

// Names
List<String> veterinaryName = [
  "Dr. Aybolit",
  "Weterinar 1",
  "Weterinar 2",
  "Çarwa",
];

// Addresses
List<String> veterinaryAdress = [
  "Юбилейная), дом, ул. Анкары 10, Aşgabat",
  "г. Ашгабат, ул. Б. Аннанова 125, Ashgabat 746000",
  "г. Ашгабат, 11-й Микрайон",
  "г. Ашгабат, этр. Багтыйарлык",
];

List<String> veterinaryImages = [
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/default.jpg",
];

// Contacts
List<String> veterinaryContacts = [
  "+99364070800",
  "+99371594990",
  "+99363071703",
  "+99362566336",
];

List<String> vetLocation = ["Aşgabat", "Aşgabat", "Aşgabat", "Aşgabat"];

List<String> vetAdditional = [
  "Kompaniýa köp ýyllyk tejribesiniň dowamynda özüni derman serişdeleriniň paýlanyş ulgamynda ygtybarly hyzmatdaş hökmünde",
];
List<String> vetAbout = [
  "16 ýyldan gowrak wagt bäri Ýowşan ykdysady assosiasiýasynyň işgärleri bize bil baglaýanlaryň durmuşyny gowulandyrmak",
];
List<String> vetWorkingHours = ["Duşenbe-Ýekşenbe, 08:00 -22:00"];

List<Veterinary> buildVeterinaryList() {
  final length = [
    veterinaryName.length,
    veterinaryAdress.length,
    veterinaryImages.length,
    veterinaryContacts.length,
  ].reduce((a, b) => a < b ? a : b);

  return List.generate(length, (i) {
    return Veterinary(
      name: veterinaryName[i],
      address: veterinaryAdress[i],
      image: veterinaryImages[i],
      contact: veterinaryContacts[i],
    );
  });
}

final List<Veterinary> veterinaryList = buildVeterinaryList();
