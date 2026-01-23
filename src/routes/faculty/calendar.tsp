import "@typespec/http";
import "@typespec/openapi3";

import "../../common.tsp";
import "../../examples/faculty/calendar.tsp";

using Http;

namespace PolitoAPI;

model FacultyCalendar {
  id?: string;

  @example("Calendario didattico")
  name: string;

  @example("Eventi legati ai corsi e alle attività accademiche.")
  description?: string;

  @example("#FF5733")
  color?: string;

  @example(true)
  supportsEventCreation: boolean;

  @example(false)
  defaultVisible?: boolean;
}

model FacultyCalendarDetail {
  calendar: FacultyCalendar;
  events: FacultyCalendarEvent[];
}

model FacultyCalendarEvent {
  @example("evt_12345")
  id?: string;

  @example("teaching")
  calendarId: string;

  @example("Brainstorming for new Activities")
  title: string;

  type: FacultyCalendarEventTypeEnum;

  @example(utcDateTime.fromISO("2023-12-18T14:00:00.000Z"))
  startDate: utcDateTime;

  @example(utcDateTime.fromISO("2023-12-18T15:30:00.000Z"))
  endDate: utcDateTime;

  @example(true)
  allDay: boolean;

  place: PlaceRef;

  @example("Sala riunioni Dipartimento DAUIN")
  externalLocation?: string;

  @example(false)
  isLive: boolean;

  materials?: FacultyCalendarEventMaterial[];

  @example("Portare il materiale per il laboratorio.")
  notes?: string;
}

model FacultyCalendarEventUpsertRequest {
  @example("Brainstorming for new Activities")
  title: string;

  type: FacultyCalendarEventTypeEnum;

  @example(utcDateTime.fromISO("2023-12-18T16:00:00.000Z"))
  startsAt: utcDateTime;

  @example(utcDateTime.fromISO("2023-12-18T17:30:00.000Z"))
  endsAt: utcDateTime;

  @example(true)
  allDay: boolean;

  @example("ROOM_002")
  placeId: string;

  @example("Sala riunioni Dipartimento DAUIN")
  externalLocation?: string;

  @example("Preparare i materiali introduttivi.")
  notes?: string;

  materialIds: string[];

  @example("https://polito.webex.com/meet/docente")
  videoConferenceUrl?: string;
}

model FacultyCalendarEventMaterial {
  @example("MAT-2023-001")
  id?: string;

  @example("Slides Introduzione")
  name: string;

  @example("https://didattica.polito.it/materials/intro.pdf")
  url: string;

  @example(FacultyCalendarMaterialType.file)
  type: FacultyCalendarMaterialType;
}

enum FacultyCalendarMaterialType {
  file,
  link,
}

enum FacultyCalendarEventTypeEnum {
  LECTURE,
  MEETING,
  OFFICE_HOUR,
  OTHER,
}

model FacultyPaginatedCalendarEventList {
  data: FacultyCalendarEvent[];

  @example(1)
  page: integer;

  @example(20)
  pageSize: integer;

  @example(100)
  total: integer;
}

@tag("Faculty - Calendar")
@route("/faculty/calendars")
interface FacultyCalendars {
  @get
  @summary("List available calendars | Elenca calendari disponibili")
  @opExample(_ex_listFacultyCalendars_resp)
  listFacultyCalendars(): OkDataResponse<FacultyCalendar[]> | BaseErrors;

  @get
  @route("/events")
  @summary("List all events from all calendars | Elenca tutti gli eventi da tutti i calendari")
  listAllFacultyCalendarEvents(
    /** Filtra per specifici calendari */
    @query(#{ explode: true }) `calendarIds[]`?: string[],

    @query fromDate?: plainDate,
    @query toDate?: plainDate,
  ): OkDataResponse<FacultyCalendarEvent[]> | BaseErrors;

  @get
  @route("/{calendarId}")
  @summary("Calendar detail with events | Dettaglio calendario ed eventi")
  @opExample(_ex_getFacultyCalendar_resp)
  getFacultyCalendar(
    @path calendarId: string,
  ): OkDataResponse<FacultyCalendarDetail> | NotFound | BaseErrors;

  @get
  @route("/{calendarId}/events")
  @summary("List calendar events | Elenca eventi del calendario")
  listFacultyCalendarEvents(
    @path calendarId: string,
    @query page?: integer,
    @query pageSize?: integer,
  ): FacultyPaginatedCalendarEventList | NotFound | BaseErrors;

  @post
  @route("/{calendarId}/events")
  @summary("Create a new calendar event | Crea un nuovo evento nel calendario")
  createFacultyCalendarEvent(
    @path calendarId: string,
    @body body: FacultyCalendarEventUpsertRequest,
  ): OkDataCreatedResponse<FacultyCalendarEvent> | NotFound | BaseErrors;

  @put
  @route("/{calendarId}/events/{eventId}")
  @summary("Create or update a calendar event | Crea o aggiorna un evento del calendario")
  upsertFacultyCalendarEvent(
    @path calendarId: string,
    @path eventId: string,
    @body body: FacultyCalendarEventUpsertRequest,
  ): OkDataResponse<FacultyCalendarEvent> | NotFound | BaseErrors;

  @delete
  @route("/{calendarId}/events/{eventId}")
  @summary("Delete a calendar event | Elimina un evento dal calendario")
  deleteFacultyCalendarEvent(
    @path calendarId: string,
    @path eventId: string,
  ): NoContentResponse | NotFound | BaseErrors;
}
