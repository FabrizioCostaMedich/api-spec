const _ex_listFacultySignableDocuments_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #[
        #{
          id: "doc_001",
          title: "Verbale esame - Analisi Matematica I - Appello 15/01/2024",
          status: "pending",
          createdAt: utcDateTime.fromISO("2024-01-16T10:00:00Z"),
          expiresAt: utcDateTime.fromISO("2024-01-23T23:59:59Z"),
        },
        #{
          id: "doc_002",
          title: "Verbale esame - Fisica I - Appello 18/01/2024",
          status: "pending",
          createdAt: utcDateTime.fromISO("2024-01-19T14:30:00Z"),
          expiresAt: utcDateTime.fromISO("2024-01-26T23:59:59Z"),
        },
        #{
          id: "doc_003",
          title: "Verbale esame - Chimica - Appello 10/01/2024",
          status: "signed",
          createdAt: utcDateTime.fromISO("2024-01-11T09:00:00Z"),
          expiresAt: null,
        },
      ],
    },
  },
};

const _ex_signFacultyDocument_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #{
        redirectUrl: "https://firma.infocert.it/sign/abc123def456",
        status: "pending",
      },
    },
  },
};

const _ex_facultySignableDocument = #{
  id: "doc_001",
  title: "Verbale esame - Analisi Matematica I - Appello 15/01/2024",
  status: "pending",
  createdAt: utcDateTime.fromISO("2024-01-16T10:00:00Z"),
  expiresAt: utcDateTime.fromISO("2024-01-23T23:59:59Z"),
};

const _ex_facultySignDocumentResponse = #{
  redirectUrl: "https://firma.infocert.it/sign/abc123def456",
  status: "pending",
};
