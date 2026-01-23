import "@typespec/http";

using Http;

namespace PolitoAPI;

const _ex_createFacultyRoomBooking_req = #{
  parameters: #{
    body: #{
      date: plainDate.fromISO("2024-03-15"),
      startTime: "10:00",
      endTime: "12:00",
      roomId: "ROOM_001",
      reason: "Lezione di recupero",
    },
  },
};

const _ex_createFacultyRoomBooking_resp = #{
  returnType: #{
    statusCode: 201,
    body: #{
      message: "Prenotazione creata con successo",
    },
  },
};

const _ex_getFacultyRoomAvailability_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #[
        #{
          roomId: "ROOM_001",
          name: "Aula 1P",
          siteId: "TO_CIT",
          capacity: 100,
          slots: #[
            #{ startTime: "08:00", endTime: "10:00" },
            #{ startTime: "14:00", endTime: "16:00" },
            #{ startTime: "16:00", endTime: "18:00" },
          ],
        },
        #{
          roomId: "ROOM_002",
          name: "Aula 2T",
          siteId: "TO_CIT",
          capacity: 150,
          slots: #[
            #{ startTime: "10:00", endTime: "12:00" },
            #{ startTime: "14:00", endTime: "18:00" },
          ],
        },
        #{
          roomId: "LAB_001",
          name: "Laboratorio Informatica 1",
          siteId: "TO_CIT",
          capacity: 40,
          slots: #[
            #{ startTime: "08:00", endTime: "12:00" },
          ],
        },
      ],
    },
  },
};

const _ex_createFacultyEventBooking_req = #{
  parameters: #{
    body: #{
      startDateTime: utcDateTime.fromISO("2024-03-15T10:00:00Z"),
      endDateTime: utcDateTime.fromISO("2024-03-15T12:00:00Z"),
      expectedParticipants: 50,
      location: "Aula Magna - Politecnico",
      reason: "Workshop su Intelligenza Artificiale",
    },
  },
};

const _ex_createFacultyEventBooking_resp = #{
  returnType: #{
    statusCode: 201,
    body: #{
      message: "Richiesta di prenotazione evento inviata con successo",
    },
  },
};

const _ex_listFacultyBookings_resp = #{
  returnType: #{
    statusCode: 200,
    body: #{
      data: #[
        #{
          id: "booking_001",
          roomId: "ROOM_001",
          roomName: "Aula 1P",
          date: plainDate.fromISO("2024-03-15"),
          startTime: "10:00",
          endTime: "12:00",
          reason: "Lezione di recupero",
          status: "confirmed",
        },
        #{
          id: "booking_002",
          roomId: "LAB_001",
          roomName: "Laboratorio Informatica 1",
          date: plainDate.fromISO("2024-03-18"),
          startTime: "14:00",
          endTime: "16:00",
          reason: "Esercitazione pratica",
          status: "confirmed",
        },
        #{
          id: "booking_003",
          date: plainDate.fromISO("2024-03-20"),
          startTime: "09:00",
          endTime: "13:00",
          reason: "Workshop su Intelligenza Artificiale",
          status: "pending",
        },
      ],
    },
  },
};
