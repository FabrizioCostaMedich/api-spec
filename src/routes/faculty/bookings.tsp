import "@typespec/http";
import "@typespec/openapi3";

import "../../common.tsp";
import "../../examples/faculty/bookings.tsp";

using Http;

namespace PolitoAPI;

/* MODELS */

model FacultyRoomBookingRequest {
  @example(plainDate.fromISO("2024-03-15"))
  date: plainDate;

  /** Formato HH:mm */
  @pattern("^\\d{2}:\\d{2}$")
  @example("10:00")
  startTime: string;

  /** Formato HH:mm */
  @pattern("^\\d{2}:\\d{2}$")
  @example("12:00")
  endTime: string;

  @example("ROOM_001")
  roomId: string;

  @example("Lezione di recupero")
  reason?: string;
}

model FacultyRoomSlot {
  @example("10:00")
  startTime: string;

  @example("12:00")
  endTime: string;
}

model FacultyRoomAvailability {
  @example("ROOM_001")
  roomId: string;

  @example("Aula 1P")
  name: string;

  @example("TO_CIT")
  siteId: string;

  @example(100)
  capacity: integer;

  slots: FacultyRoomSlot[];
}

model FacultyEventBookingRequest {
  @example(utcDateTime.fromISO("2024-03-15T10:00:00Z"))
  startDateTime: utcDateTime;

  @example(utcDateTime.fromISO("2024-03-15T12:00:00Z"))
  endDateTime: utcDateTime;

  @example(50)
  expectedParticipants: integer;

  @example("Aula Magna - Politecnico")
  location: string;

  @example("Workshop su Intelligenza Artificiale")
  reason: string;
}

model FacultyBooking {
  @example("booking_001")
  id: string;

  @example("ROOM_001")
  roomId?: string;

  @example("Aula 1P")
  roomName?: string;

  @example(plainDate.fromISO("2024-03-15"))
  date: plainDate;

  @example("10:00")
  startTime: string;

  @example("12:00")
  endTime: string;

  @example("Lezione di recupero")
  reason?: string;

  @example("confirmed")
  status: string;
}

/* INTERFACE */

@tag("Faculty - Room Booking")
@route("/faculty/rooms/bookings")
interface FacultyRoomBookings {
  @post
  @summary("Book a room | Prenota aula/laboratorio")
  @opExample(_ex_createFacultyRoomBooking_req)
  @opExample(_ex_createFacultyRoomBooking_resp)
  createFacultyRoomBooking(
    @body body: FacultyRoomBookingRequest,
  ): CreatedAckResponse | Conflict | BaseErrors;

  @get
  @route("/availability")
  @summary("Check room availability | Verifica disponibilità aule")
  @opExample(_ex_getFacultyRoomAvailability_resp)
  getFacultyRoomAvailability(
    @query date: plainDate,
    @query siteId?: string,
    @query features?: string[],
  ): OkDataResponse<FacultyRoomAvailability[]> | BaseErrors;
}

@tag("Faculty - Event Booking")
@route("/faculty/events/bookings")
interface FacultyEventBookings {
  @post
  @summary("Book event space | Prenota spazio per evento")
  @opExample(_ex_createFacultyEventBooking_req)
  @opExample(_ex_createFacultyEventBooking_resp)
  createFacultyEventBooking(
    @body body: FacultyEventBookingRequest,
  ): CreatedAckResponse | Conflict | BaseErrors;
}

@tag("Faculty - Bookings")
@route("/faculty/bookings")
interface FacultyBookings {
  @get
  @summary("List my bookings | Elenca prenotazioni")
  @opExample(_ex_listFacultyBookings_resp)
  listFacultyBookings(
    @query dateFrom?: plainDate,
    @query dateTo?: plainDate,
  ): OkDataResponse<FacultyBooking[]> | BaseErrors;

  @delete
  @route("/{bookingId}")
  @summary("Cancel booking | Annulla prenotazione")
  cancelFacultyBooking(@path bookingId: string): NoContentResponse | NotFound | BaseErrors;
}
