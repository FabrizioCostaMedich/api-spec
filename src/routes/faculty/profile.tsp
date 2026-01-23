import "@typespec/http";
import "@typespec/openapi3";

import "../../common.tsp";
import "../../examples/faculty/profile.tsp";

using Http;

namespace PolitoAPI;

model FacultyPublication {
  @example("pub_001")
  id: string;

  @example("Advanced Topics in Distributed Systems")
  name: string;
}

model FacultyAssignedCourse {
  @example("251007")
  id: string;

  @example("System and device programming")
  name: string;

  @example("01NYHOV")
  shortcode: string;
}

model FacultyProfile {
  @example("d123456")
  id: string;

  @example("Mario")
  name: string;

  @example("mario.rossi@polito.it")
  email: string;

  @example("+39 011 090 7000")
  phone?: string;

  @example("Via Roma 10, Torino")
  residence?: string;

  @example("Via Roma 10, Torino")
  fiscalResidence?: string;

  @example("IT60X0542811101000000123456")
  iban?: string;

  @example("DAUIN - Dipartimento di Automatica e Informatica")
  department?: string | null;

  publications?: FacultyPublication[];
  assignedCourses?: FacultyAssignedCourse[];
}

model FacultyProfileUpdateRequest {
  residence?: string;
  fiscalResidence?: string;
  phone?: string;
  email?: string;
}

enum FacultyMessageType {
  emergency,
  event,
  personal,
  teacher,
  secretariat,
  exams,
  mfa,
}

model FacultyMessage {
  @example(63775600)
  id: integer;

  @example("Nuovo messaggio dalla Segreteria Studenti")
  title: string;

  @example("Si comunica che...")
  message: string;

  @example(FacultyMessageType.secretariat)
  type: FacultyMessageType;

  @example(150157)
  senderId?: integer | null;

  @example(utcDateTime.fromISO("2021-10-05T10:00:00Z"))
  sentAt: utcDateTime;

  @example(true)
  isRead: boolean;
}

model FacultyNotification {
  @example(63775600)
  id: integer;

  @example("Nuovo materiale nel corso di Fisica")
  title: string;

  @example("È stato caricato nuovo materiale didattico.")
  message?: string | null;

  @example(utcDateTime.fromISO("2021-10-05T10:00:00Z"))
  createdAt: utcDateTime;

  @example(false)
  isRead: boolean;
}

model FacultyNotificationPreferences {
  @example(true)
  emailEnabled: boolean;

  @example(true)
  pushEnabled: boolean;
}

model FacultyDeadline {
  @example("deadline_001")
  id: string;

  @example("Scadenza verbale esame")
  title: string;

  @example("Analisi Matematica I - Appello 15/01")
  description?: string;

  @example(plainDate.fromISO("2024-01-23"))
  dueDate: plainDate;
}

model FacultyEmailBadge {
  @example(5)
  count: integer;
}

@tag("Faculty - Profile")
@route("/faculty")
interface FacultyProfileRoutes {
  @get
  @route("/me")
  @summary("Get faculty profile | Profilo docente")
  @opExample(_ex_getFacultyProfile_resp)
  getFacultyProfile(): OkDataResponse<FacultyProfile> | BaseErrors;

  @patch(#{ implicitOptionality: true })
  @route("/me")
  @summary("Update faculty profile | Aggiorna profilo docente")
  @opExample(_ex_updateFacultyProfile_req)
  @opExample(_ex_updateFacultyProfile_resp)
  updateFacultyProfile(
    @body body: FacultyProfileUpdateRequest,
  ): OkDataResponse<FacultyProfile> | BaseErrors;

  @get
  @route("/deadlines")
  @summary("List deadlines | Elenca scadenze")
  @opExample(_ex_getFacultyDeadlines_resp)
  getFacultyDeadlines(): OkDataResponse<FacultyDeadline[]> | BaseErrors;

  @get
  @route("/unreadEmails")
  @summary("Get unread emails count | Recupera numero email non lette")
  @opExample(_ex_getFacultyUnreadEmailsCount_resp)
  getFacultyUnreadEmailsCount(): OkDataResponse<FacultyEmailBadge> | BaseErrors;

  @get
  @route("/messages")
  @summary("List messages | Elenca messaggi")
  @opExample(_ex_getFacultyMessages_resp)
  getFacultyMessages(): OkDataResponse<FacultyMessage[]> | BaseErrors;

  @delete
  @route("/messages/{messageId}")
  @summary("Delete message | Cancella messaggio")
  deleteFacultyMessage(
    @path messageId: integer,
  ): NoContentResponse | NotFound | BaseErrors;

  @put
  @route("/messages/{messageId}/read")
  @summary("Mark message as read | Segna messaggio come letto")
  markFacultyMessageAsRead(
    @path messageId: integer,
  ): OkResponse<{}> | NotFound | BaseErrors;

  @get
  @route("/notifications")
  @summary("List notifications | Elenca notifiche")
  @opExample(_ex_getFacultyNotifications_resp)
  getFacultyNotifications(): OkDataResponse<FacultyNotification[]> | BaseErrors;

  @get
  @route("/notifications/preferences")
  @summary("Get notification preferences | Preferenze notifiche")
  @opExample(_ex_getFacultyNotificationPreferences_resp)
  getFacultyNotificationPreferences(
  ): OkDataResponse<FacultyNotificationPreferences> | BaseErrors;

  @patch(#{ implicitOptionality: true })
  @route("/notifications/preferences")
  @summary("Update notification preferences | Aggiorna preferenze notifiche")
  @opExample(_ex_updateFacultyNotificationPreferences_req)
  @opExample(_ex_updateFacultyNotificationPreferences_resp)
  updateFacultyNotificationPreferences(
    @body body: FacultyNotificationPreferences,
  ): OkDataResponse<FacultyNotificationPreferences> | BaseErrors;

  @delete
  @route("/notifications/{notificationId}")
  @summary("Delete notification | Cancella notifica")
  deleteFacultyNotification(
    @path notificationId: integer,
  ): NoContentResponse | NotFound | BaseErrors;

  @put
  @route("/notifications/{notificationId}/read")
  @summary("Mark notification as read | Segna notifica come letta")
  markFacultyNotificationAsRead(
    @path notificationId: integer,
  ): OkResponse<{}> | NotFound | BaseErrors;
}
