import "@typespec/http";
import "@typespec/openapi3";

import "../../common.tsp";

using Http;
using OpenAPI;

namespace PolitoAPI;

// --- Common Profile Models ---

model Deadline {
  id?: numeric;

  @example("Termine per l'iscrizione e pagamento della prima rata")
  name: string;

  @example("Iscrizioni e pagamento tasse")
  type: string;

  url: string | null;

  @example(plainDate.fromISO("2022-10-11"))
  date: plainDate;
}

model EmailBadge {
  @example("99+")
  unreadEmails: string;
}

@example(MessageType.secretariat)
enum MessageType {
  emergency,
  event,
  personal,
  teacher,
  secretariat,
  exams,
  mfa,
}

model Message {
  @example(63775600)
  id: numeric;

  @example("Nuovo messaggio dalla Segreteria Studenti")
  title: string;

  @example("Puoi venire a ritirare la tua smartcard")
  message: string | null;

  @example(MessageType.secretariat)
  type: MessageType;

  @example(150157)
  senderId: numeric | null;

  @example(utcDateTime.fromISO("2021-10-05T10:00:00Z"))
  sentAt: utcDateTime;

  @example(true)
  isRead: boolean;
}

model Notification {
  @example(63775600)
  id: numeric;

  @example("Nuovo materiale nel corso di Fisica")
  title: string;

  @example("Nuovo file presentazione.pdf aggiunto al materiale del corso di Fisica")
  message: string | null;

  /** An array representing the hierarchical path to the object this notification is related to (replicates the navigation/modules structure) */
  @example(#["courses", "258674", "notices"])
  scope?: string[];

  @example(utcDateTime.fromISO("2021-10-05T10:00:00Z"))
  sentAt: utcDateTime;

  @example(true)
  isRead: boolean;
}

model NotificationPreferences {
  @example(true)
  notices: boolean;

  @example(true)
  files: boolean;

  @example(true)
  lectures: boolean;

  @example(true)
  bookings: boolean;

  @example(true)
  tickets: boolean;
}

model UpdateNotificationPreferencesRequest {
  data: {
    @example(true)
    notices?: boolean;

    @example(true)
    files?: boolean;

    @example(true)
    lectures?: boolean;

    @example(true)
    bookings?: boolean;

    @example(true)
    tickets?: boolean;
  };
}

model GuideField {
  label: string;
  value: string;
  isCopyEnabled?: boolean;
}

model Guide {
  id: string;
  listTitle: string;
  title: string;
  intro: string;
  fields: GuideField[];
  sections: GuideSection[];
}
