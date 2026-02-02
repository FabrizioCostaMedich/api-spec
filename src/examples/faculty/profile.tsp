import "@typespec/http";

using Http;

namespace PolitoAPI;

const _ex_getFacultyProfile_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #{
        id: "d123456",
        name: "Mario",
        email: "mario.rossi@polito.it",
        phone: "+39 011 090 7000",
        residence: "Via Roma 10, Torino",
        fiscalResidence: "Via Roma 10, Torino",
        iban: "IT60X0542811101000000123456",
        department: "DAUIN - Dipartimento di Automatica e Informatica",
        publications: #[
          #{ id: "pub_001", name: "Advanced Topics in Distributed Systems" },
          #{ id: "pub_002", name: "Machine Learning for IoT Applications" },
        ],
        assignedCourses: #[
          #{ id: "251007", name: "System and device programming", shortcode: "01NYHOV" },
          #{ id: "252121", name: "Web Applications II", shortcode: "01TXSOV" },
        ],
      },
    },
  },
};

const _ex_updateFacultyProfile_req = #{
  parameters: #{
    body: #{
      residence: "Corso Duca degli Abruzzi 24, Torino",
      fiscalResidence: "Corso Duca degli Abruzzi 24, Torino",
      phone: "+39 011 090 7001",
      email: "mario.rossi@polito.it",
    },
  },
};

const _ex_updateFacultyProfile_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #{
        id: "d123456",
        name: "Mario",
        email: "mario.rossi@polito.it",
        phone: "+39 011 090 7001",
        residence: "Corso Duca degli Abruzzi 24, Torino",
        fiscalResidence: "Corso Duca degli Abruzzi 24, Torino",
        iban: "IT60X0542811101000000123456",
        department: "DAUIN - Dipartimento di Automatica e Informatica",
        publications: #[],
        assignedCourses: #[],
      },
    },
  },
};
