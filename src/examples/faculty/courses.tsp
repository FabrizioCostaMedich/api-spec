import "@typespec/http";

using Http;

namespace PolitoAPI;

const _ex_getFacultyCourses_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #[
        #{
          id: 251007,
          name: "System and device programming",
          shortcode: "01NYHOV",
          cfu: 10,
          teachingPeriod: "2-2",
          teacherId: 2893,
          previousEditions: #[#{ id: 251007, year: "2024" }],
          isModule: false,
          year: "2025",
        },
        #{
          id: 252121,
          name: "Web Applications II",
          shortcode: "01TXSOV",
          cfu: 6,
          teachingPeriod: "2-2",
          teacherId: 2235,
          previousEditions: #[],
          isModule: false,
          year: "2025",
        },
        #{
          id: 252138,
          name: "Information systems security",
          shortcode: "01TYMOV",
          cfu: 6,
          teachingPeriod: "1-1",
          teacherId: 1847,
          previousEditions: #[],
          isModule: false,
          year: "2025",
        },
      ],
    },
  },
};

const _ex_getFacultyCourse_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #{
        id: 251007,
        name: "System and device programming",
        shortcode: "01NYHOV",
        cfu: 10,
        teachingPeriod: "2-2",
        teacherId: 2893,
        previousEditions: #[#{ id: 251007, year: "2024" }],
        isModule: false,
        year: "2025",
        moodleCourses: #[#{ id: "12345", name: "SDP 2025" }],
      },
    },
  },
};

const _ex_listFacultyCourseStudents_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #[
        #{
          id: "s123456",
          firstName: "Mario",
          lastName: "Rossi",
          username: "s123456",
          picture: #{ url: "https://didattica.polito.it/photos/s123456.jpg" },
        },
        #{
          id: "s234567",
          firstName: "Luigi",
          lastName: "Verdi",
          username: "s234567",
          picture: #{ url: "https://didattica.polito.it/photos/s234567.jpg" },
        },
      ],
    },
  },
};

const _ex_listFacultyCourseAssignments_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #[
        #{
          id: "asn_001",
          title: "Laboratorio 1 - Thread e processi",
          publishedAt: utcDateTime.fromISO("2024-03-10T14:00:00Z"),
          submittedBy: "s123456",
        },
        #{
          id: "asn_002",
          title: "Laboratorio 2 - Sincronizzazione",
          publishedAt: utcDateTime.fromISO("2024-03-17T16:30:00Z"),
          submittedBy: "s234567",
        },
      ],
    },
  },
};

const _ex_listFacultyLectures_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #[
        #{
          id: "lec_001",
          courseId: "251007",
          title: "Lezione 1 - Introduzione al corso",
          type: "LECTURE",
          startsAt: utcDateTime.fromISO("2024-03-04T10:00:00Z"),
          endsAt: utcDateTime.fromISO("2024-03-04T12:00:00Z"),
          topic: "Presentazione del corso e obiettivi",
          language: "it",
          room: #{
            buildingId: "TO_CIT22",
            floorId: "XPTE",
            roomId: "036",
            siteId: "TO_CIT",
            name: "Aula 1P",
          },
          staff: #[
            #{ personId: "p001", name: "Mario Rossi", role: "OWNER" },
          ],
        },
        #{
          id: "lec_002",
          courseId: "251007",
          title: "Lezione 2 - Thread e processi",
          type: "LECTURE",
          startsAt: utcDateTime.fromISO("2024-03-06T10:00:00Z"),
          endsAt: utcDateTime.fromISO("2024-03-06T12:00:00Z"),
          topic: "Concetti base di concorrenza",
          language: "it",
          room: #{
            buildingId: "TO_CIT22",
            floorId: "XPTE",
            roomId: "036",
            siteId: "TO_CIT",
            name: "Aula 1P",
          },
          staff: #[
            #{ personId: "p001", name: "Mario Rossi", role: "OWNER" },
            #{ personId: "p002", name: "Luigi Verdi", role: "COLLABORATOR" },
          ],
        },
      ],
      page: 1,
      pageSize: 20,
      total: 2,
    },
  },
};

const _ex_getFacultyLecture_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #{
        id: "lec_001",
        courseId: "251007",
        title: "Lezione 1 - Introduzione al corso",
        type: "LECTURE",
        startsAt: utcDateTime.fromISO("2024-03-04T10:00:00Z"),
        endsAt: utcDateTime.fromISO("2024-03-04T12:00:00Z"),
        topic: "Presentazione del corso e obiettivi",
        language: "it",
        room: #{
          buildingId: "TO_CIT22",
          floorId: "XPTE",
          roomId: "036",
          siteId: "TO_CIT",
          name: "Aula 1P",
        },
        staff: #[
          #{ personId: "p001", name: "Mario Rossi", role: "OWNER" },
        ],
      },
    },
  },
};

const _ex_listFacultyCourseCollaborators_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #[
        #{
          personId: "p002",
          name: "Luigi Verdi",
          role: "Teaching Assistant",
          courses: #["251007", "252121"],
          permissions: #["CAN_READ", "CAN_EDIT"],
        },
        #{
          personId: "p003",
          name: "Anna Bianchi",
          role: "Tutor",
          courses: #["251007"],
          permissions: #["CAN_READ"],
        },
      ],
    },
  },
};

const _ex_facultyCourseOverview = #{
  id: 251007,
  name: "System and device programming",
  shortcode: "01NYHOV",
  cfu: 10,
  teachingPeriod: "2-2",
  teacherId: 2893,
  previousEditions: #[#{ id: 251007, year: "2024" }],
  isModule: false,
  year: "2025",
};

const _ex_facultyLecture = #{
  id: "lec_001",
  courseId: "251007",
  title: "Lezione 1 - Introduzione al corso",
  type: "LECTURE",
  startsAt: utcDateTime.fromISO("2024-03-04T10:00:00Z"),
  endsAt: utcDateTime.fromISO("2024-03-04T12:00:00Z"),
  topic: "Presentazione del corso e obiettivi",
  language: "it",
  room: #{
    buildingId: "TO_CIT22",
    floorId: "XPTE",
    roomId: "036",
    siteId: "TO_CIT",
    name: "Aula 1P",
  },
  staff: #[#{ personId: "p001", name: "Mario Rossi", role: "OWNER" }],
};

const _ex_facultyCollaborator = #{
  personId: "p002",
  name: "Luigi Verdi",
  role: "Teaching Assistant",
  courses: #["251007"],
  permissions: #["CAN_READ", "CAN_EDIT"],
};
