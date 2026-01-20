const _ex_listFacultyCalendars_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #[
        #{
          id: "teaching",
          name: "Calendario didattico",
          description: "Eventi legati ai corsi e alle attività accademiche.",
          color: "#1976D2",
          supportsEventCreation: false,
          defaultVisible: true,
        },
        #{
          id: "personal",
          name: "Calendario personale",
          description: "Eventi personali del docente.",
          color: "#FF5733",
          supportsEventCreation: true,
          defaultVisible: false,
        },
      ],
    },
  },
};

const _ex_getFacultyCalendar_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #{
        calendar: #{
          id: "teaching",
          name: "Calendario didattico",
          description: "Eventi legati ai corsi e alle attività accademiche.",
          color: "#1976D2",
          supportsEventCreation: false,
          defaultVisible: true,
        },
        events: #[
          #{
            id: "evt_12345",
            calendarId: "teaching",
            title: "Lezione Analisi Matematica I",
            type: "LECTURE",
            startDate: utcDateTime.fromISO("2023-12-18T14:00:00.000Z"),
            endDate: utcDateTime.fromISO("2023-12-18T15:30:00.000Z"),
            allDay: false,
            place: #{
              buildingId: "TO_CIT22",
              floorId: "XPTE",
              roomId: "036",
              siteId: "TO_CIT",
              name: "Aula 1P",
            },
            isLive: false,
            notes: "Portare il materiale per il laboratorio.",
          },
        ],
      },
    },
  },
};

const _ex_facultyCalendarEvent = #{
  id: "evt_12345",
  calendarId: "personal",
  title: "Brainstorming for new Activities",
  type: "MEETING",
  startDate: utcDateTime.fromISO("2023-12-18T14:00:00.000Z"),
  endDate: utcDateTime.fromISO("2023-12-18T15:30:00.000Z"),
  allDay: false,
  place: #{
    buildingId: "TO_CIT22",
    floorId: "XPTE",
    roomId: "036",
    siteId: "TO_CIT",
    name: "Sala riunioni DAUIN",
  },
  externalLocation: "Sala riunioni Dipartimento DAUIN",
  isLive: false,
  materials: #[
    #{
      id: "MAT-2023-001",
      name: "Slides Introduzione",
      url: "https://didattica.polito.it/materials/intro.pdf",
      type: "file",
    },
  ],
  notes: "Portare il materiale per il laboratorio.",
};
