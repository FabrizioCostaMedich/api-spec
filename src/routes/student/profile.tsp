import "@typespec/http";
import "@typespec/openapi3";

import "../../common.tsp";
import "../../examples/student.tsp";
import "../common/profile.tsp";

using Http;
using OpenAPI;

namespace PolitoAPI;

@tag("Student")
interface StudentProfileOperations {
  @route("/deadlines")
  @get
  @summary("List deadlines | Elenca scadenze")
  @opExample(_ex_getDeadlines_resp)
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

@tag("Student")
@route("/messages")
interface Messages {
  @get
  @summary("List messages | Elenca messaggi")
  getMessages(): OkDataResponse<Message[]> | BaseErrors;

  @route("/{messageId}")
  @delete
  @summary("Delete a message | Cancella un messaggio")
  deleteMessage(@path messageId: integer): NoContentResponse | BaseErrors;

  @route("/{messageId}/read")
  @put
  @summary("Mark a message as read | Segna un messaggio come letto")
  markMessageAsRead(@path messageId: integer): NoContentResponse | BaseErrors;
}

@tag("Student")
@route("/notifications")
interface Notifications {
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
  ): NoContentResponse | BaseErrors;

  @route("/{notificationId}/read")
  @put
  @summary("Mark a notification as read | Segna una notifica come letta")
  markNotificationAsRead(
    @path notificationId: integer,
  ): NoContentResponse | BaseErrors;
}
