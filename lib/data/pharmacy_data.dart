class Pharmacy {
  final String name;
  final String address;
  final String image;
  final String contact;

  const Pharmacy({
    required this.name,
    required this.address,
    required this.image,
    required this.contact,
  });
}

// Names
List<String> pharmacies = [
  "Dermanhana №1",
  "Dermanhana №2",
  "Dermanhana №3",
  "Dermanhana №4",
  "Dermanhana №5",
  "Dermanhana №6",
  "Dermanhana №7",
  "Dermanhana №9",
  "Dermanhana №10",
  "Dermanhana №11",
  "Dermanhana №12",
  "Dermanhana №13",
  "Dermanhana №14",
  "Sapaly Zaman",
  "Şypaly Çomuç",
  "Melhemli Diýarym",
  "Çebşek",
  "Tebip",
  "Dermansaglyk",
  "Atig",
  "Altyn Çäç",
  "Mähirli ýol",
  "Hazar OKS",
  "Dag Oty",
  "Dertdeş",
  "Rysgally el",
  "Behiştli Dünýä",
  "Şirin nabat",
  "Baýry",
  "Dostlukly zähmet",
  "Boý Bodron",
  "Dostluk Dünýäsi",
  "Aşgabat",
  "Ýandak",
];

// Addresses
List<String> adresses = [
  "г.Ашгабат, Мир 1, ул. Молодежная, д.15",
  "г.Ашгабат, ул. Худайбердыева",
  "г.Ашгабат, перекресток ул. Андалиба и ул. А. Бердыева (Мира-Гражданская)",
  "г.Ашгабат, ул. А. Навоий, 40",
  "г.Ашгабат, ул. А. Бердыева, 14 (бывшая ул. Гражданская)",
  "г.Ашгабат, проспект Махтумкули,155 (напротив 2-го парка)",
  "г.Ашгабат, Гаудан А",
  "г.Ашгабат, ул. Таслама",
  "г.Ашгабат, ул. Кемине, 178 (цирк)",
  "г.Ашгабат, проспект Махтумкули, 98",
  "г.Ашгабат, ул. А. Ниязова (напротив Дома здоровья №6)",
  "Рухабатский этрап, Гекдже",
  "г.Ашгабат, проспект Махтумкули, 29",
  "ул. Юнус Эмре, Мир 7/2 дом 30",
  "г. Ашхабад, ул. Сона Мурадова дом 21 (базар Лялезар)",
  "г.Ашгабат, ул. Махтумкули ТРЦ Гульземин",
  "Ашхабад, ул. С. Мырадова (бывш. С. Разина), дом 3A.",
  "г.Ашгабат, ул.Ю.Эмре, Мир 4/1, д.5",
  "Туркменистан, г. Ашхабад, (Мир 4/1), ул. Андалиба [1958], Дом 70",
  "г.Ашгабат, Битарап Туркменистан шаелы, 223/1",
  "г.Ашгабат, ул. А. Ниязова, 186 (бывшая Чехова, дом с надписью (Bereket)",
  "г.Ашгабат, ул. 1934 (бывшая ул. Бомако), д. 43 (напротив базара 100 фонтанов)",
  "г.Ашгабат, проспект Махтумкули, 105",
  "г.Ашгабат, ул. Баба аннанова, 35 (Ташаузский базар)",
  "г. Ашгабат, ул.А. Ниязова, 176",
  "B.S.Türkmenbaşy şaýoly(Lenin), 71/1 ýaşaýyş jaýyynyň awtoduralgasy",
  "Aşgabat, Türkmenistanyň Gahrymany Atamyrat Nyýazow şaýoly köçesi, 55/1 jaýy («Umyt» binasy)",
  "Aşgabat ş. Gurtly ýaşaýyş jaý toplumy 56-njy jaý",
  "г. Ашгабат, Гуртли",
  "15-nji tapgyr (Rysgally) söwda dükany",
  "г.Ашгабат, ТЦ Ашгабат Ялкымы",
  "г.Ашгабат, ул. Махтумкули 181 А (30 мкр, напротив зоомагазина)",
  "г.Ашгабат, ул. Огузхана, 66 (напротив оптовки)",
  "г.Ашгабат, ул. Худайбердыева, 134 (дом быта Гунча)",
];

List<String> images = [
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/default.jpg",
  "assets/images/sapaly-zaman.jpg",
  "assets/images/sypaly-comuc.jpg",
  "assets/images/melhem-diyar.jpg",
  "assets/images/cebshek.jpg",
  "assets/images/tebip.jpg",
  "assets/images/default.jpg",
  "assets/images/atig.jpg",
  "assets/images/default.jpg",
  "assets/images/mahirli-yol.jpg",
  "assets/images/hazar-oks.jpg",
  "assets/images/default.jpg",
  "assets/images/dertdesh.jpg",
  "assets/images/rysgally-el.jpg",
  "assets/images/behishti.jpg",
  "assets/images/shirin-nabat.jpg",
  "assets/images/bayry.jpg",
  "assets/images/dostlukly.jpg",
  "assets/images/boy-bodron.jpg",
  "assets/images/default.jpg",
  "assets/images/ag-dermanhana.jpg",
  "assets/images/default.jpg",
];

// Contacts
List<String> contacts = [
  "+99312452015",
  "+99312225292",
  "756114",
  "930545",
  "766796",
  "360369",
  "260075",
  "906916",
  "363244",
  "+99312935294",
  "+99312230429",
  "+99312324903",
  "+99312274631",
  "+99365515766",
  "+99312286500",
  "+99312903686",
  "+99312286344",
  "+99312475444",
  "+99312472697",
  "+99312211884",
  "+99312414444",
  "+99312420708",
  "+99312935080",
  "+99312439090",
  "+99312414175",
  "+99312227222",
  "+99312288080",
  "+99312979595",
  "+99312979339",
  "415501",
  "+99362377878",
  "+99312340131",
  "+99312262828",
  "220303",
];

List<String> location = [
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
  "Aşgabat",
];

List<String> additional = [
  "Kompaniýa köp ýyllyk tejribesiniň dowamynda özüni derman serişdeleriniň paýlanyş ulgamynda ygtybarly hyzmatdaş hökmünde",
];
List<String> about = [
  "16 ýyldan gowrak wagt bäri Ýowşan ykdysady assosiasiýasynyň işgärleri bize bil baglaýanlaryň durmuşyny gowulandyrmak",
];
List<String> workingHours = ["Duşenbe-Ýekşenbe, 08:00 -22:00"];

List<Pharmacy> buildPharmacyList() {
  final length = [
    pharmacies.length,
    adresses.length,
    images.length,
    contacts.length,
  ].reduce((a, b) => a < b ? a : b);

  return List.generate(length, (i) {
    return Pharmacy(
      name: pharmacies[i],
      address: adresses[i],
      image: images[i],
      contact: contacts[i],
    );
  });
}

final List<Pharmacy> pharmacyList = buildPharmacyList();
