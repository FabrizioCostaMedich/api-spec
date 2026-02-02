import "@typespec/http";
import "@typespec/openapi3";

import "../../common.tsp";
import "../../examples/faculty/profile.tsp";
import "../common/profile.tsp";

using Http;
using OpenAPI;

namespace PolitoAPI;

// --- Faculty-specific Models ---

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

// --- Faculty-specific Interface (only /faculty/me) ---

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
}

// --- Faculty profile operations (same models as student, /faculty prefix) ---

@tag("Faculty - Profile")
@route("/faculty")
interface FacultyProfileOperations {
  @route("/deadlines")
  @get
  @summary("List deadlines | Elenca scadenze")
  getDeadlines(
    /** First day - defaults to 7 days before today */
    @query fromDate?: plainDate,

    /** Last day - defaults to 7 days after today */
    @query toDate?: plainDate,
  ): OkDataResponse<Deadline[]> | BaseErrors;

  @route("/unreadEmails")
  @get
  @summary("Retrieve unread emails number | Recupera il numero di email non lette")
  getUnreadEmailsNumber(): OkDataResponse<EmailBadge> | BaseErrors;

  @route("/preferences")
  @patch(#{ implicitOptionality: true })
  @summary("Update device preferences | Aggiorna preferenze del dispositivo")
  updateDevicePreferences(
    @body body: UpdatePreferencesRequest,
  ): NoContentResponse | BaseErrors;

  @route("/guides")
  @get
  @summary("Get guides | Mostra guide")
  getGuides(): OkDataResponse<Guide[]> | BaseErrors;
}

@tag("Faculty - Profile")
@route("/faculty/messages")
interface FacultyMessages {
  @get
  @summary("List messages | Elenca messaggi")
  getMessages(): OkDataResponse<Message[]> | BaseErrors;

  @route("/{messageId}")
  @delete
  @summary("Delete a message | Cancella un messaggio")
  deleteMessage(@path messageId: integer): NoContentResponse | NotFound | BaseErrors;

  @route("/{messageId}/read")
  @put
  @summary("Mark a message as read | Segna un messaggio come letto")
  markMessageAsRead(@path messageId: integer): OkResponse<{}> | NotFound | BaseErrors;
}

@tag("Faculty - Profile")
@route("/faculty/notifications")
interface FacultyNotifications {
  @get
  @summary("List notifications | Elenca notifiche")
  getNotifications(): OkDataResponse<Notification[]> | BaseErrors;

  @route("/preferences")
  @get
  @summary("Get notification preferences | Ottieni preferenze notifiche")
  getNotificationPreferences(): OkDataResponse<NotificationPreferences> | BaseErrors;

  @route("/preferences")
  @patch(#{ implicitOptionality: true })
  @summary("Update notification preferences | Aggiorna preferenze notifiche")
  updateNotificationPreferences(
    @body body: UpdateNotificationPreferencesRequest,
  ): NoContentResponse | BaseErrors;

  @route("/{notificationId}")
  @delete
  @summary("Delete a notification | Cancella una notifica")
  deleteNotification(
    @path notificationId: integer,
  ): NoContentResponse | NotFound | BaseErrors;

  @route("/{notificationId}/read")
  @put
  @summary("Mark a notification as read | Segna una notifica come letta")
  markNotificationAsRead(
    @path notificationId: integer,
  ): OkResponse<{}> | NotFound | BaseErrors;
}
