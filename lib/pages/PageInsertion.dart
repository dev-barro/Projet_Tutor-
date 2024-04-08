 import 'package:application/pages/ModelsTable.dart';

List<Universite> universites = [
    Universite(
        id: 1,
        nom: 'UNIVERSITÉ NORBERT ZONGO - KOUDOUGOU  [UNZ]',
        adresse: 'Koudougou,secteur 8'),
    Universite(
        id: 2, nom: 'UNIVERSITÉ THOMAS SANKARA  [UTS]', adresse: 'Ouagadougou'),
    Universite(
        id: 3,
        nom: 'UNIVERSITÉ NAZI BONI - BOBO DIOULASSO  [UNB]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 4,
        nom: 'CENTRE UNIVERSITAIRE DE BANFORA  [CUP-B]',
        adresse: 'BANFORA'),
    Universite(
        id: 5,
        nom: 'UNIVERSITÉ JOSEPH KI-ZERBO  [UJKZ]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 6, nom: 'UNIVERSITÉ DE OUAHIGOUYA  [UOHG]', adresse: 'Ouahigouya'),
    Universite(
        id: 7, nom: 'UNIVERSITÉ DE DEDOUGOU  [UDDG]', adresse: 'Dédougou'),
    Universite(
        id: 8,
        nom: 'CENTRE UNIVERSITAIRE DE GAOUA  [CUP-G] ',
        adresse: 'GAOUA'),
    Universite(
        id: 9,
        nom: 'UNIVERSITÉ DE FADA N\'GOURMA  [UFDG]',
        adresse: 'FADA N\'GOURMA'),
    Universite(
        id: 10, nom: ' CENTRE UNIVERSITAIRE DE DORI  [CUD]', adresse: 'DORI'),
    Universite(
        id: 11,
        nom: 'CENTRE UNIVERSITAIRE POLYTECHNIQUE DE KAYA  [CUP-K]',
        adresse: 'KAYA'),
    Universite(
        id: 12,
        nom: 'CENTRE UNIVERSITAIRE DE TENKODOGO  [CU-T]',
        adresse: 'TENKODOGO'),
    Universite(
        id: 13,
        nom: 'UNIVERSITE SAINT THOMAS D’AQUIN  [USTA]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 14, nom: 'UNIVERSITE OUAGA 3S  [UO3S]', adresse: 'Ouagadougou'),
    Universite(
        id: 15,
        nom: 'ÉCOLE SUPERIEURE DE MICROFINANCE  [ESMI]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 16,
        nom: 'INSTITUT SUPERIEUR DE TECHNOLOGIES   [IST]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 17,
        nom:
            'UNIVERSITÉ PRIVÉE CATHOLIQUE SAINT JOSEPH (EX ESPK) DE KAYA   [ESPK]',
        adresse: 'KAYA'),
    Universite(
        id: 18,
        nom:
            'ÉCOLE SUPERIEURE DE COMMERCE ET D’INFORMATIQUE DE GESTION  [ESCO-IGES]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 19,
        nom: 'INSTITUT INTERNATIONAL DE MANAGEMENT DE OUAGADOUGOU  [IIM-OUAGA]',
        adresse: 'OUAGADOUGOU'),
    Universite(
        id: 20,
        nom: 'INSTITUT SUPERIEUR DE TECHNOLOGIE ET DE GESTION  [ISTG]',
        adresse: 'OUAGADOUGOU'),
    Universite(
        id: 21,
        nom: 'INSTITUT SUPERIEUR DE GESTION DE OUAHIGOUYA  [ISGO]',
        adresse: 'OUAHIGOUYA'),
    Universite(
        id: 22,
        nom: 'ECOLE SUPERIEURE DES TRAVAUX PUBLICS DE OUAGADOUGOU  [ESTPO]',
        adresse: 'OUAGADOUGOU'),
    Universite(
        id: 23,
        nom: 'ECOLE SUPERIEURE DE COMMERCE  [ESC]',
        adresse: 'OUAGADOUGOU'),
    Universite(
        id: 24,
        nom: 'INSTITUT SUPERIEUR DE SECURITE HUMAINE  [ISSH]',
        adresse: 'OUAGADOUGOU'),
    Universite(
        id: 25, nom: 'UNIVERSITE AUBE NOUVELLE  [UAN]', adresse: 'OUAGADOUGOU'),
    Universite(
        id: 26,
        nom: 'CENTRE UNIVERSITAIRE MANGA  [CU_MANGA]',
        adresse: 'MANGA'),
    Universite(
        id: 27,
        nom: 'CENTRE UNIVERSITAIRE ZINIARE  [CU_ZINIARE]',
        adresse: 'ZINIARE'),
    Universite(
        id: 28,
        nom: 'ECOLE POLYTECHNIQUE DE OUAGADOUGOU  [EPO]',
        adresse: 'OUAGADOUGOU'),
    Universite(
        id: 29,
        nom:
            'INSTITUT SUPÉRIEUR DE GÉNIE ÉLECTRIQUE DU BURKINA FASO  [ISGE-BF]',
        adresse: 'OUAGADOUGOU'),
    Universite(
        id: 30,
        nom: 'SUP MANAGEMENT BURKINA  [SUPM B]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 31,
        nom: 'INSTITUT SUPERIEUR DES FILIERES PROFESSIONNALISANT  [ISFP]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 32,
        nom: 'ECOLE SUPERIEURE POLYTECHNIQUE PRIVEE LA JEUNESSE  [ESUP-J]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 33,
        nom: 'ECOLE SUPERIEURE DES TECHNIQUES AVANCEES  [ESTA]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 34,
        nom: 'INSTITUT SUPERIEUR PRIVE POLYTECHNIQUE  [ISPP]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 35,
        nom: 'INSTITUT TENGTUUMA GEOSERVICES DE OUAGADOUGOU  [ITTGO]',
        adresse: 'OUAGADOUGOU'),
    Universite(
        id: 36,
        nom:
            'INSTITUT SUPERIEUR DES LETTRES, LANGUES, SCIENCES HUMAINES ET SOCIALES  [ISLLSHS]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 37,
        nom: 'APIDON ACADEMY OF SCIENCE   [AAS]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 38,
        nom: 'INSTITUT AFRICAIN DE MANAGEMENT DE OUAGADOUGOU  [IAM-OUAGA]',
        adresse: 'OUAGADOUGOU'),
    Universite(
        id: 39,
        nom:
            'CENTRE D’ETUDE ET DE RECHERCHE PANAFRICAIN EN MANAGEMENT POUR LE DEVELOPPEMENT  [CERPAMAD]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 40,
        nom: 'ÉCOLE SUPERIEURE INTERNATIONALE DE MANAGEMENT   [ESIM]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 41,
        nom: 'ECOLE SUPERIEURE DE GENIE RURALE ET DE L’ENVIRONNEMENT  [ESGRE]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 42,
        nom: 'INSTITUT SUPERIEUR DE MANAGEMENT DE KOUDOUGOU  [ISM/K]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 43,
        nom: 'INSTITUT SUPERIEUR POLYTECHNIQUE « LES ELITES »  [ISPE]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 44,
        nom: 'INSTITUT DES SCIENCES POUR L’ENTREPRISE ET LA GESTION  [ISEG]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 45, nom: 'SCHOOL OF MANAGEMENT  [SOM]', adresse: 'Ouagadougou'),
    Universite(
        id: 46,
        nom: 'INSTITUT AFRICAIN DES INDUSTRIES CULTURELLES  [IAIC]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 47,
        nom: 'ÉCOLE SUPERIEURE POLYTECHNIQUE EXCELLE  [ESUPEX]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 48,
        nom: 'ÉCOLE D’ARCHITECTURE ET DE GENIE CIVIL DE OUAGADOUGOU   [EAGCO]',
        adresse: 'OUAGADOUGOU'),
    Universite(
        id: 49,
        nom:
            'UNIVERSITE CATHOLIQUE DE L’AFRIQUE DE L’OUEST-UNITE UNIVERSITAIRE A BOBO DIOULASSO  [UCAO-UUB]',
        adresse: 'BOBO DIOULASSO'),
    Universite(
        id: 50, nom: 'UNIVERSITE VIRTUELLE  [UV-BF]', adresse: 'KOUDOUGOU'),
    Universite(
        id: 51,
        nom:
            'INSTITUT SUPÉRIEUR DE TECHNOLOGIES APPLIQUÉES ET DE MANAGEMENT  [ISTAPEM]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 52,
        nom: 'INSTITUT SUPÉRIEUR DE LA COMMUNICATION ET DU MULTIMÉDIA  [ISCOM]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 53,
        nom: 'UNIVERSITÉ PRIVÉE/SWISS UMEF UNIVERSITY OF BURKINA FASO  [SUUBF]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 54,
        nom: 'UNIVERSITE DE TECHNOLOGIE ET DE MANAGEMENT  [UTM]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 55,
        nom: 'UNIVERSITE SAINT DOMINIQUE AFRIQUE OUEST   [USDAO]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 56,
        nom: 'BURKINA INSTITUTE OF TECHNOLOGY  [BIT]',
        adresse: 'KOUDOUGOU'),
    Universite(
        id: 57,
        nom: 'HAUTE ETUDES DE MANAGEMENT ET D’AGROPASTORALE»  [HEMA]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 58,
        nom: 'INSTITUT DES SCIENCES DE L’ENTREPRISE ET DU MANAGEMENT  [INSEM]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 59,
        nom:
            'INSTITUT DES SCIENCES CAMPUS DU CENTRE ( EX INSTITUT PRIVE ONLINE TRAINING CENTER)  [(ISC-Centre) (EX IPOTC)]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 60,
        nom:
            'INSTITUT DE FORMATION ET DE RECHERCHE INTERDISCIPLINAIRE EN SCIENCES DE LA SANTE ET DE L’EDUCATION ET ANNEXE  [IFRISSE]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 61,
        nom:
            'ECOLE SUPERIEURE PRIVE EXCELLENCESUPÉRIEURE PRIVÉ DE EXCELLENCE  [ESE]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 62,
        nom: 'ECOLE SUPERIEURE AFRICAINE LA FLAMME ESPOIR ET ANNEXE  [ESAFE]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 63,
        nom: 'INSTITUT DE L’ECONOMIE INTERNATIONALE  [IEI]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 64,
        nom: 'INSTITUT DE FORMATION COLBERT  [IFC]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 65,
        nom: 'INSTITUT AFRICAIN DE FINANCE ISLAMIQUE ET DE GESTION  [IAFIG]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 66,
        nom:
            'INSTITUT DE GESTION DES RISQUES MINIERS ET DU DEVELOPPEMENT DURABLE  [INGRIDD]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 67,
        nom: 'INSTITUT POLYTECHNIQUE AFRICAIN  [IPA]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 68,
        nom:
            'INSTITUT INTERNATIONAL DE FORMATION A L’EXPERTISE COMPTABLE   [2IFEC]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 69,
        nom: 'INSTITUT DES SCIENCES TECHNIQUES ET DE MANAGEMENT  [ISTM]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 70,
        nom:
            'INSTITUT DES SCIENCES ET TECHNIQUES DE INFORMATION DOCUMENTAIRE  [ISTID]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 71,
        nom:
            'INSTITUT SUPERIEUR PRIVE DE PHILOSOPHIE « MAISON LAVIGERIE »  [ISPP-ML]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 72,
        nom: 'UNIVERSITES AUBE NOUVELLE BOBO  [AUN-BOBO]',
        adresse: 'BOBO '),
    Universite(
        id: 73,
        nom: 'INSTITUT SUPERIEUR PRIVÉ AS-SALAM   [ISPA]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 74,
        nom: ' INSTITUT des TECHNOLOGIES MODERNES du DEVELOPPEMENT   [ITMD]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 75,
        nom: 'BUILDING CAPACITY INSTITUTE  [BCI]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 76, nom: 'UMANIS BUSNESS SCHOOL  [UBS]', adresse: 'Ouagadougou'),
    Universite(
        id: 77,
        nom: 'ECOLE COLE BURKINABE DES AFFAIRES  [EBA]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 78,
        nom: 'INSTITUT PRIVE AFRICAIN MODERNE BURKINA  [IPAM]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 79,
        nom: 'INSTITUT SUPERIEUR PRIVE SAINT AUGUSTIN   [ISPSAD]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 80,
        nom: 'UNIVERSITE NOTRE DAME DAFRIQUE  [UNDA]',
        adresse: 'Ouagadougou'),
    Universite(
        id: 81,
        nom: 'INSTITUT DES SCIENCES VEENEM-WATA DE KOUDOUGOU  [ISVK]',
        adresse: 'Ouagadougou'),

    // Ajoutez les autres universités ici...
  ];

 