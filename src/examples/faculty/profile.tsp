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

const _ex_getFacultyDeadlines_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #[
        #{
          id: "deadline_001",
          title: "Scadenza verbale esame",
          description: "Analisi Matematica I - Appello 15/01",
          dueDate: plainDate.fromISO("2024-01-23"),
        },
        #{
          id: "deadline_002",
          title: "Consegna programma corso",
          description: "System and device programming - A.A. 2024/2025",
          dueDate: plainDate.fromISO("2024-02-01"),
        },
      ],
    },
  },
};

const _ex_getFacultyUnreadEmailsCount_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #{
        count: 5,
      },
    },
  },
};

const _ex_getFacultyMessages_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #[
        #{
          id: 63775600,
          title: "Nuovo messaggio dalla Segreteria Studenti",
          message: "Si comunica che gli uffici rimarranno chiusi il giorno 24 dicembre.",
          type: FacultyMessageType.secretariat,
          senderId: 150157,
          sentAt: utcDateTime.fromISO("2021-10-05T10:00:00Z"),
          isRead: false,
        },
        #{
          id: 63775601,
          title: "Convocazione Consiglio di Dipartimento",
          message: "Si convoca il Consiglio di Dipartimento per il giorno 15 gennaio ore 14:30.",
          type: FacultyMessageType.event,
          senderId: null,
          sentAt: utcDateTime.fromISO("2021-10-04T14:30:00Z"),
          isRead: true,
        },
      ],
    },
  },
};

const _ex_getFacultyNotifications_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #[
        #{
          id: 63775600,
          title: "Nuovo materiale nel corso di Fisica",
          message: "È stato caricato nuovo materiale didattico.",
          createdAt: utcDateTime.fromISO("2021-10-05T10:00:00Z"),
          isRead: false,
        },
        #{
          id: 63775601,
          title: "Nuovo iscritto all'appello",
          message: "Uno studente si è iscritto all'appello del 15/01.",
          createdAt: utcDateTime.fromISO("2021-10-04T09:00:00Z"),
          isRead: true,
        },
      ],
    },
  },
};

const _ex_getFacultyNotificationPreferences_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #{
        emailEnabled: true,
        pushEnabled: true,
      },
    },
  },
};

const _ex_updateFacultyNotificationPreferences_req = #{
  parameters: #{
    body: #{
      emailEnabled: true,
      pushEnabled: false,
    },
  },
};

const _ex_updateFacultyNotificationPreferences_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #{
        emailEnabled: true,
        pushEnabled: false,
      },
    },
  },
};
