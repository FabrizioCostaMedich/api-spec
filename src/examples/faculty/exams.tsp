import "@typespec/http";

using Http;

namespace PolitoAPI;

const _ex_listFacultyExams_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #[
        #{
          id: "exam_001",
          courseId: "251007",
          courseName: "System and device programming",
          date: plainDate.fromISO("2024-02-15"),
          room: "Aula 1P",
          enrolledCount: 45,
        },
        #{
          id: "exam_002",
          courseId: "252121",
          courseName: "Web Applications II",
          date: plainDate.fromISO("2024-02-20"),
          room: "Aula 2T",
          enrolledCount: 32,
        },
        #{
          id: "exam_003",
          courseId: "252138",
          courseName: "Information systems security",
          date: plainDate.fromISO("2024-01-25"),
          room: null,
          enrolledCount: 28,
        },
      ],
      page: 1,
      pageSize: 20,
      total: 3,
    },
  },
};

const _ex_getFacultyExam_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #{
        id: "exam_001",
        courseId: "251007",
        courseName: "System and device programming",
        date: plainDate.fromISO("2024-02-15"),
        room: "Aula 1P",
        enrolledCount: 45,
        enrolled: #[
          #{
            personId: "s123456",
            name: "Mario Rossi",
            degree: "Ingegneria Informatica",
            email: "mario.rossi@studenti.polito.it",
            note: null,
          },
          #{
            personId: "s234567",
            name: "Luigi Verdi",
            degree: "Ingegneria Informatica",
            email: "luigi.verdi@studenti.polito.it",
            note: "Studente lavoratore",
          },
          #{
            personId: "s345678",
            name: "Anna Bianchi",
            degree: "Ingegneria del Cinema",
            email: "anna.bianchi@studenti.polito.it",
            note: null,
          },
        ],
      },
    },
  },
};

const _ex_notifyFacultyExamSubscribers_req = #{
  parameters: #{
    examId: "exam_001",
    body: #{
      subject: "Comunicazione appello",
      message: "Si comunica che l'appello si svolgerà in Aula 1P alle ore 9:00. Presentarsi con documento di identità.",
      channels: #["push", "email"],
    },
  },
};

const _ex_notifyFacultyExamSubscribers_resp = #{
  returnType: #{
    statusCode: 202,
  },
};

const _ex_addFacultyExamEnrollment_req = #{
  parameters: #{
    examId: "exam_001",
    body: #{
      personId: "s456789",
      note: "Studente fuori corso",
    },
  },
};

const _ex_addFacultyExamEnrollment_resp = #{
  returnType: #{
    statusCode: 201,
    body: #{
      data: #{
        personId: "s456789",
        name: "Giuseppe Neri",
        degree: "Ingegneria Informatica",
        email: "giuseppe.neri@studenti.polito.it",
        note: "Studente fuori corso",
      },
    },
  },
};
