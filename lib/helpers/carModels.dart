List<String> brands = [
  'Audi',
  'Bentley',
  'BMW',
  'Cadillac',
  'Chevrolet',
  'Chrysler',
  'Ferrari',
  'Fiat',
  'Ford',
  'Genesis',
  'GMC',
  'Harley-Davidson',
  'Honda',
  'Hyundai',
  'Jaguar',
  'Jeep',
  'Karma',
  'Kia',
  'Land Rover',
  'Lexus',
  'Lincoln',
  'Lucid',
  'Mazda',
  'Mercedes-Benz',
  'Mini',
  'Mitsubishi',
  'Nissan',
  'Polestar',
  'Porsche',
  'Rivian',
  'Smart',
  'Subaru',
  'Tesla',
  'Toyota',
  'Victory',
  'Vinfast',
  'Volkswagen',
  'Volvo',
  'Zero',
  'Other'
];

List models = [
  {
    "Maker": "Audi",
    "Model": "A3 E-Tron",
    "Years": [2016, 2017, 2018]
  },
  {
    "Maker": "Audi",
    "Model": "A7",
    "Years": [2022, 2023]
  },
  {
    "Maker": "Audi",
    "Model": "E-Tron",
    "Years": [2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Audi",
    "Model": "E-tron GT",
    "Years": [2021, 2022, 2023],
    "Acceleration": 3.3,
    "TopSpeed": 250,
    "Range": 405,
    "Efficiency": 210,
    "FastChargeSpeed": 810,
    "Drive": "All Wheel Drive"
  },
  {
    "Maker": "Audi",
    "Model": "E-tron Sportback 55 Quattro",
    "Years": [2021, 2022, 2023],
    "Miles": 0.44,
    "Acceleration": 5.7,
    "TopSpeed": 200,
    "Range": 375,
    "Efficiency": 231,
    "FastChargeSpeed": 600,
    "Drive": "All Wheel Drive"
  },
  {
    "Maker": "Audi",
    "Model": "Q4 E-Tron",
    "Years": [2021, 2022, 2023],
    "Acceleration": 9.0,
    "TopSpeed": 160,
    "Range": 280,
    "Efficiency": 184,
    "FastChargeSpeed": 390,
    "Drive": "Rear Wheel Drive"
  },
  {
    "Maker": "Audi",
    "Model": "Q4 E-Tron Sportback",
    "Years": [2021, 2022, 2023],
    "Acceleration": 9.0,
    "TopSpeed": 160,
    "Range": 295,
    "Efficiency": 175,
    "FastChargeSpeed": 410,
    "Drive": "Rear Wheel Drive"
  },
  {
    "Maker": "Audi",
    "Model": "Q5",
    "Years": [2023]
  },
  {
    "Maker": "Bentley",
    "Model": "Bentayga Hybrid",
    "Years": [2022, 2023]
  },
  {
    "Maker": "BMW",
    "Model": "3 Series",
    "Years": [2021, 2022]
  },
  {
    "Maker": "BMW",
    "Model": "330e",
    "Years": [2017, 2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "BMW",
    "Model": "5 Series",
    "Years": [2021, 2022]
  },
  {
    "Maker": "BMW",
    "Model": "530e",
    "Years": [2017, 2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "BMW",
    "Model": "7 Series",
    "Years": [2020, 2021, 2022]
  },
  {
    "Maker": "BMW",
    "Model": "740Le XDrive",
    "Years": [2017, 2018]
  },
  {
    "Maker": "BMW",
    "Model": "i3",
    "Years": [2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022],
    "Miles": 0.3,
    "Acceleration": 7.3,
    "TopSpeed": 150,
    "Range": 235,
    "Efficiency": 161,
    "FastChargeSpeed": 270,
    "Drive": "Rear Wheel Drive"
  },
  {
    "Maker": "BMW",
    "Model": "i3 REX",
    "Years": [2019]
  },
  {
    "Maker": "BMW",
    "Model": "i3 BEV",
    "Years": [2014, 2015, 2016, 2017],
    "Miles": 0.27
  },
  {
    "Maker": "BMW",
    "Model": "i4",
    "Years": [2021, 2022, 2023],
    "Acceleration": 3.9,
    "TopSpeed": 225,
    "Range": 450,
    "Efficiency": 179,
    "FastChargeSpeed": 630,
    "Drive": "All Wheel Drive"
  },
  {
    "Maker": "BMW",
    "Model": "i8",
    "Years": [2015, 2016, 2017, 2018, 2019, 2020]
  },
  {
    "Maker": "BMW",
    "Model": "iX",
    "Years": [2021, 2022, 2023]
  },
  {
    "Maker": "BMW",
    "Model": "x3 xDrive40e",
    "Years": [2020, 2021, 2022]
  },
  {
    "Maker": "BMW",
    "Model": "x5 xDrive40e",
    "Years": [2016, 2017, 2018, 2019, 2020, 2021, 2022]
  },
  {
    "Maker": "BMW",
    "Model": "x5 xDrive45e",
    "Years": [2023]
  },
  {
    "Maker": "Cadillac",
    "Model": "ELR",
    "Years": [2014]
  },
  {
    "Maker": "Cadillac",
    "Model": "LYRIQ",
    "Years": [2023]
  },
  {
    "Maker": "Chevrolet",
    "Model": "Bolt EUV",
    "Years": [2022, 2023],
    "Miles": 0.29
  },
  {
    "Maker": "Chevrolet",
    "Model": "Bolt EV",
    "Years": [2017, 2018, 2019, 2020, 2021, 2022, 2023],
    "Miles": 0.28
  },
  {
    "Maker": "Chevrolet",
    "Model": "Spark",
    "Years": [2011, 2012, 2013, 2014, 2015, 2016],
    "Miles": 0.28
  },
  {
    "Maker": "Chevrolet",
    "Model": "Volt",
    "Years": [2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020]
  },
  {
    "Maker": "Chrysler",
    "Model": "Pacifica PHEV",
    "Years": [2017, 2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Ferrari",
    "Model": "SF90 Stradale",
    "Years": [2022]
  },
  {
    "Maker": "Fiat",
    "Model": "500e",
    "Years": [2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022],
    "Miles": 0.3,
    "Acceleration": 9.0,
    "TopSpeed": 150,
    "Range": 245,
    "Efficiency": 152,
    "FastChargeSpeed": 410,
    "Drive": "Front Wheel Drive"
  },
  {
    "Maker": "Ford",
    "Model": "C-MAX Energi",
    "Years": [2013, 2014, 2015, 2016, 2017, 2018]
  },
  {
    "Maker": "Ford",
    "Model": "Escape",
    "Years": [2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Ford",
    "Model": "F-150 Lightning",
    "Years": [2022, 2023]
  },
  {
    "Maker": "Ford",
    "Model": "Focus EV",
    "Years": [2013, 2014, 2015, 2016, 2017, 2018],
    "Miles": 0.32
  },
  {
    "Maker": "Ford",
    "Model": "Fusion Energi",
    "Years": [2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020]
  },
  {
    "Maker": "Ford",
    "Model": "Mustang Mach-E",
    "Years": [2021, 2022, 2023],
    "Miles": 0.34,
    "Acceleration": 6.9,
    "TopSpeed": 180,
    "Range": 355,
    "Efficiency": 197,
    "FastChargeSpeed": 380,
    "Drive": "Rear Wheel Drive"
  },
  {
    "Maker": "Genesis",
    "Model": "G80",
    "Years": [2022, 2023]
  },
  {
    "Maker": "Genesis",
    "Model": "GV60",
    "Years": [2022, 2023]
  },
  {
    "Maker": "GMC",
    "Model": "HUMMER EV Edition 1 pickup",
    "Years": [2022, 2023]
  },
  {
    "Maker": "Harley-Davidson",
    "Model": "Livewire",
    "Years": [2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Honda",
    "Model": "Clarity EV",
    "Years": [2019, 2020, 2021],
    "Miles": 0.3
  },
  {
    "Maker": "Honda",
    "Model": "Clarity plug-in hybrid",
    "Years": [2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Honda",
    "Model": "Fit EV",
    "Years": [2013, 2014],
    "Miles": 0.29
  },
  {
    "Maker": "Hyundai",
    "Model": "Ioniq 5",
    "Years": [2022, 2023],
    "Acceleration": 5.2,
    "TopSpeed": 185,
    "Range": 370,
    "Efficiency": 196,
    "FastChargeSpeed": 860,
    "Drive": "All Wheel Drive"
  },
  {
    "Maker": "Hyundai",
    "Model": "Ioniq Electric",
    "Years": [2017, 2018, 2019, 2020, 2021],
    "Miles": 0.25,
    "Acceleration": 9.7,
    "TopSpeed": 165,
    "Range": 250,
    "Efficiency": 153,
    "FastChargeSpeed": 220,
    "Drive": "Front Wheel Drive"
  },
  {
    "Maker": "Hyundai",
    "Model": "Ioniq Electric Plus",
    "Years": [2019, 2020]
  },
  {
    "Maker": "Hyundai",
    "Model": "Ioniq Hybrid",
    "Years": [2017, 2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Hyundai",
    "Model": "Kona Electric",
    "Years": [2019, 2020, 2021, 2022, 2023],
    "Miles": 0.27,
    "Acceleration": 7.9,
    "TopSpeed": 167,
    "Range": 395,
    "Efficiency": 162,
    "FastChargeSpeed": 370,
    "Drive": "Front Wheel Drive"
  },
  {
    "Maker": "Hyundai",
    "Model": "Santa Fe plug-in hybrid",
    "Years": [2022, 2023]
  },
  {
    "Maker": "Hyundai",
    "Model": "Sonata plug-in hybrid",
    "Years": [2016, 2017, 2018]
  },
  {
    "Maker": "Hyundai",
    "Model": "Tucson plug-in hybrid",
    "Years": [2022, 2023]
  },
  {
    "Maker": "Jaguar",
    "Model": "I-Pace",
    "Years": [2019, 2020, 2021, 2022, 2023],
    "Miles": 0.44,
    "Acceleration": 4.8,
    "TopSpeed": 200,
    "Range": 365,
    "Efficiency": 232,
    "FastChargeSpeed": 340,
    "Drive": "All Wheel Drive"
  },
  {
    "Maker": "Jeep",
    "Model": "Grand Cherokee 4xe",
    "Years": [2023]
  },
  {
    "Maker": "Jeep",
    "Model": "Wrangler 4xe",
    "Years": [2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Karma",
    "Model": "Revero",
    "Years": [2019, 2020]
  },
  {
    "Maker": "Kia",
    "Model": "EV6",
    "Years": [2022, 2023],
    "Acceleration": 3.5,
    "TopSpeed": 260,
    "Range": 395,
    "Efficiency": 196,
    "FastChargeSpeed": 920,
    "Drive": "All Wheel Drive"
  },
  {
    "Maker": "Kia",
    "Model": "Niro EV",
    "Years": [2019, 2020, 2021, 2022, 2023],
    "Miles": 0.3,
    "Acceleration": 7.8,
    "TopSpeed": 167,
    "Range": 370,
    "Efficiency": 173,
    "FastChargeSpeed": 350,
    "Drive": "Front Wheel Drive"
  },
  {
    "Maker": "Kia",
    "Model": "Niro PHEV",
    "Years": [2017, 2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Kia",
    "Model": "Optima PHEV",
    "Years": [2017, 2018, 2019, 2020]
  },
  {
    "Maker": "Kia",
    "Model": "Sorento PHEV",
    "Years": [2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Kia",
    "Model": "Soul EV",
    "Years": [2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023],
    "Miles": 0.31,
    "Acceleration": 7.9,
    "TopSpeed": 167,
    "Range": 370,
    "Efficiency": 173,
    "FastChargeSpeed": 350,
    "Drive": "Front Wheel Drive"
  },
  {
    "Maker": "Land Rover",
    "Model": "Range Rover HSE P400E VHR",
    "Years": [2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Land Rover",
    "Model": "Range Rover Sport HSE P400E VH",
    "Years": [2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Lexus",
    "Model": "NX 450h+",
    "Years": [2022, 2023]
  },
  {
    "Maker": "Lexus",
    "Model": "RZ 450e",
    "Years": [2022, 2023]
  },
  {
    "Maker": "Lincoln",
    "Model": "Aviator Grand Touring",
    "Years": [2022, 2023]
  },
  {
    "Maker": "Lincoln",
    "Model": "Corsair Grand Touring",
    "Years": [2021, 2022, 2023]
  },
  {
    "Maker": "Lucid",
    "Model": "Air",
    "Years": [2022, 2023],
    "Acceleration": 4.2,
    "TopSpeed": 200,
    "Range": 540,
    "Efficiency": 157,
    "FastChargeSpeed": 1410,
    "Drive": "Rear Wheel Drive"
  },
  {
    "Maker": "Lucid",
    "Model": "Air Grand Touring",
    "Years": [2022, 2023],
    "Miles": 0.26,
    "Acceleration": 3.2,
    "TopSpeed": 270,
    "Range": 660,
    "Efficiency": 167,
    "FastChargeSpeed": 1380,
    "Drive": "All Wheel Drive"
  },
  {
    "Maker": "Mazda",
    "Model": "MX-30",
    "Years": [2020, 2021, 2022, 2023],
    "Acceleration": 9.7,
    "TopSpeed": 140,
    "Range": 170,
    "Efficiency": 176,
    "FastChargeSpeed": 180,
    "Drive": "Front Wheel Drive"
  },
  {
    "Maker": "Mercedes-Benz",
    "Model": "B 250e",
    "Years": [2016, 2017, 2018],
    "Miles": 0.4
  },
  {
    "Maker": "Mercedes-Benz",
    "Model": "EQB",
    "Years": [2022, 2023],
    "Acceleration": 6.5,
    "TopSpeed": 160,
    "Range": 340,
    "Efficiency": 196,
    "FastChargeSpeed": 400,
    "Drive": "All Wheel Drive"
  },
  {
    "Maker": "Mercedes-Benz",
    "Model": "EQC",
    "Years": [2019, 2020, 2021, 2022],
    "Acceleration": 5.1,
    "TopSpeed": 180,
    "Range": 370,
    "Efficiency": 216,
    "FastChargeSpeed": 440,
    "Drive": "All Wheel Drive"
  },
  {
    "Maker": "Mercedes-Benz",
    "Model": "EQE",
    "Years": [2022, 2023]
  },
  {
    "Maker": "Mercedes-Benz",
    "Model": "EQS",
    "Years": [2022, 2023],
    "Acceleration": 6.2,
    "TopSpeed": 210,
    "Range": 640,
    "Efficiency": 168,
    "FastChargeSpeed": 840,
    "Drive": "Rear Wheel Drive"
  },
  {
    "Maker": "Mercedes-Benz",
    "Model": "GLC 350e",
    "Years": [2018, 2019, 2020]
  },
  {
    "Maker": "Mercedes-Benz",
    "Model": "GLE 550e",
    "Years": [2017, 2018]
  },
  {
    "Maker": "Mercedes-Benz",
    "Model": "S 560e",
    "Years": [2019, 2020, 2021, 2022]
  },
  {
    "Maker": "Mini",
    "Model": "Cooper SE",
    "Years": [2020, 2021, 2022, 2023],
    "Miles": 0.31,
    "Acceleration": 7.3,
    "TopSpeed": 150,
    "Range": 185,
    "Efficiency": 156,
    "FastChargeSpeed": 260,
    "Drive": "Front Wheel Drive"
  },
  {
    "Maker": "Mini",
    "Model": "Countryman S E",
    "Years": [2017, 2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Mitsubishi",
    "Model": "i-MiEV",
    "Years": [2012, 2013, 2014, 2015, 2016, 2017, 2018],
    "Miles": 0.3
  },
  {
    "Maker": "Mitsubishi",
    "Model": "Outlander PHEV",
    "Years": [2017, 2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Nissan",
    "Model": "Ariya",
    "Years": [2022, 2023],
    "Acceleration": 7.5,
    "TopSpeed": 160,
    "Range": 335,
    "Efficiency": 188,
    "FastChargeSpeed": 450,
    "Drive": "Front Wheel Drive"
  },
  {
    "Maker": "Nissan",
    "Model": "Leaf",
    "Years": [
      2012,
      2013,
      2014,
      2015,
      2016,
      2017,
      2018,
      2019,
      2020,
      2021,
      2022,
      2023
    ],
    "Miles": 0.3,
    "Acceleration": 7.9,
    "TopSpeed": 144,
    "Range": 220,
    "Efficiency": 164,
    "FastChargeSpeed": 230,
    "Drive": "Front Wheel Drive"
  },
  {
    "Maker": "Nissan",
    "Model": "Leaf Plus",
    "Years": [2019, 2020, 2021, 2022, 2023],
    "Acceleration": 7.3,
    "TopSpeed": 157,
    "Range": 325,
    "Efficiency": 172,
    "FastChargeSpeed": 390,
    "Drive": "Front Wheel Drive"
  },
  {
    "Maker": "Polestar",
    "Model": "Polestar 1",
    "Years": [2019]
  },
  {
    "Maker": "Polestar",
    "Model": "Polestar 2",
    "Years": [2020, 2021, 2022, 2023],
    "Miles": 0.37,
    "Acceleration": 7.4,
    "TopSpeed": 160,
    "Range": 350,
    "Efficiency": 174,
    "FastChargeSpeed": 450,
    "Drive": "Front Wheel Drive"
  },
  {
    "Maker": "Porsche",
    "Model": "918 Spyder",
    "Years": [2014, 2015]
  },
  {
    "Maker": "Porsche",
    "Model": "Cayenne S E-Hybrid",
    "Years": [2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Porsche",
    "Model": "Panamera 4 E-Hybrid",
    "Years": [2019, 2020]
  },
  {
    "Maker": "Porsche",
    "Model": "Panamera S E-Hybrid",
    "Years": [2014, 2015, 2016, 2017, 2018, 2019, 2021, 2022, 2023]
  },
  {
    "Maker": "Porsche",
    "Model": "Taycan EV",
    "Years": [2020, 2021, 2022, 2023],
    "Miles": 0.41,
    "Acceleration": 5.4,
    "TopSpeed": 230,
    "Range": 395,
    "Efficiency": 180,
    "FastChargeSpeed": 790,
    "Drive": "Rear Wheel Drive"
  },
  {
    "Maker": "Rivian",
    "Model": "R1S",
    "Years": [2021, 2022, 2023]
  },
  {
    "Maker": "Rivian",
    "Model": "R1T",
    "Years": [2021, 2022, 2023]
  },
  {
    "Maker": "Smart",
    "Model": "Fortwo Electric Drive",
    "Years": [2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021],
    "Miles": 0.32,
    "Acceleration": 11.6,
    "TopSpeed": 130,
    "Range": 100,
    "Efficiency": 167,
    "FastChargeSpeed": null,
    "Drive": "Rear Wheel Drive"
  },
  {
    "Maker": "Subaru",
    "Model": "Crosstrek",
    "Years": [2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Subaru",
    "Model": "Solterra",
    "Years": [2023]
  },
  {
    "Maker": "Tesla",
    "Model": "CyberTruck",
    "Years": [2022],
    "Acceleration": 9.7,
    "TopSpeed": 140,
    "Range": 170,
    "Efficiency": 176,
    "FastChargeSpeed": 180,
    "Drive": "Front Wheel Drive"
  },
  {
    "Maker": "Tesla",
    "Model": "Model 3",
    "Years": [2017, 2018, 2019, 2020, 2021, 2022, 2023],
    "Miles": 0.25
  },
  {
    "Maker": "Tesla",
    "Model": "Model S",
    "Years": [
      2012,
      2013,
      2014,
      2015,
      2016,
      2017,
      2018,
      2019,
      2020,
      2021,
      2022,
      2023
    ]
  },
  {
    "Maker": "Tesla",
    "Model": "Model X",
    "Years": [2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023],
    "Miles": 0.33
  },
  {
    "Maker": "Tesla",
    "Model": "Model Y Long Range",
    "Years": [2020, 2021, 2022, 2023],
    "Miles": 0.28,
    "Acceleration": 5.1,
    "TopSpeed": 217,
    "Range": 450,
    "Efficiency": 169,
    "FastChargeSpeed": 750,
    "Drive": "All Wheel Drive"
  },
  {
    "Maker": "Tesla",
    "Model": "Model Y Performance Long Range",
    "Years": [2020, 2021, 2022, 2023],
    "Miles": 0.3,
    "Acceleration": 3.7,
    "TopSpeed": 241,
    "Range": 430,
    "Efficiency": 177,
    "FastChargeSpeed": 720,
    "Drive": "All Wheel Drive"
  },
  {
    "Maker": "Toyota",
    "Model": "BZ4X",
    "Years": [2023]
  },
  {
    "Maker": "Toyota",
    "Model": "Prius Prime / plug-in",
    "Years": [2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Toyota",
    "Model": "RAV4 Prime / plug-in",
    "Years": [2021, 2022, 2023]
  },
  {
    "Maker": "Victory",
    "Model": "Empulse TT",
    "Years": [2016, 2017, 2018]
  },
  {
    "Maker": "Vinfast",
    "Model": "VF8",
    "Years": [2022, 2023]
  },
  {
    "Maker": "Vinfast",
    "Model": "VF9",
    "Years": [2022, 2023]
  },
  {
    "Maker": "Volkswagen",
    "Model": "e-Golf",
    "Years": [2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023],
    "Miles": 0.28
  },
  {
    "Maker": "Volkswagen",
    "Model": "ID.4 (Pro)",
    "Years": [2020, 2021, 2022, 2023],
    "Miles": 0.34,
    "Acceleration": 8.5,
    "TopSpeed": 160,
    "Range": 410,
    "Efficiency": 188,
    "FastChargeSpeed": 500,
    "Drive": "Rear Wheel Drive"
  },
  {
    "Maker": "Volvo",
    "Model": "S60 T8 Plug-in",
    "Years": [2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Volvo",
    "Model": "S90 T8 Plug-in",
    "Years": [2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Volvo",
    "Model": "V60",
    "Years": [2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Volvo",
    "Model": "XC40",
    "Years": [2020, 2021, 2022, 2023],
    "Miles": 0.43,
    "Acceleration": 4.9,
    "TopSpeed": 180,
    "Range": 340,
    "Efficiency": 221,
    "FastChargeSpeed": 440,
    "Drive": "All Wheel Drive"
  },
  {
    "Maker": "Volvo",
    "Model": "XC60 T8 Plug-in",
    "Years": [2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Volvo",
    "Model": "XC90 T8 Plug-in",
    "Years": [2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023]
  },
  {
    "Maker": "Zero",
    "Model": "DS",
    "Years": [2015, 2016, 2017, 2018]
  },
  {
    "Maker": "Zero",
    "Model": "DSR",
    "Years": [2016, 2017, 2018, 2019, 2020, 2021, 2022]
  },
  {
    "Maker": "Zero",
    "Model": "S",
    "Years": [2015, 2016, 2017, 2018]
  },
  {
    "Maker": "Zero",
    "Model": "SR",
    "Years": [2015, 2016, 2017, 2018]
  }
];

Map<String, dynamic> carMiles = {
  "Audi_E-Tron_2021": 0.45,
  "Audi_E-Tron_2019": 0.46,
  "Chevrolet_BOLT EV_2020": 0.29,
  "Chevrolet_BOLT EV_2021": 0.29,
  "Fiat_500e_2013": 0.29,
  "Fiat_500e_2015": 0.29,
  "Fiat_500e_2014": 0.29,
  "Ford_Focus EV_2018": 0.31,
  "Ford_Focus EV_2017": 0.31,
  "Hyundai_Kona Electric_2019": 0.28,
  "Kia_Soul EV_2016": 0.32,
  "Kia_Soul EV_2015": 0.32,
  "Kia_Soul EV_2017": 0.32,
  "Kia_Soul EV_2020": 0.29,
  "Nissan_Leaf_2013": 0.29,
  "Nissan_Leaf_2012": 0.34,
  "Nissan_Leaf_2011": 0.34,
  "Volkswagen_e-Golf_2016": 0.29,
  "Volkswagen_e-Golf_2015": 0.29,
  "Tesla_Model X_2016": 0.39,
  "Tesla_Model X_2018": 0.39,
};
