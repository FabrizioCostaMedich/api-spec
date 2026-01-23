import "@typespec/http";
import "@typespec/openapi3";

import "../../common.tsp";
import "../../examples/faculty/exams.tsp";

using Http;

namespace PolitoAPI;

/* MODELS */

model FacultyExamEnrollment {
  @example("s123456")
  personId: string;

  @example("Mario Rossi")
  name: string;

  @example("Ingegneria Informatica")
  degree?: string | null;

  @example("mario.rossi@studenti.polito.it")
  email?: string | null;

  @example("Studente lavoratore")
  note?: string | null;
}

model FacultyExamSummary {
  @example("exam_001")
  id: string;

  @example("251007")
  courseId: string;

  @example("System and device programming")
  courseName: string;

  @example(plainDate.fromISO("2024-02-15"))
  date: plainDate;

  @example("Aula 1P")
  room?: string | null;

  @example(45)
  enrolledCount: integer;
}

model FacultyExam {
  ...FacultyExamSummary;
  enrolled: FacultyExamEnrollment[];
}

model FacultyPaginatedExamList {
  data: FacultyExamSummary[];

  @example(1)
  page: integer;

  @example(20)
  pageSize: integer;

  @example(100)
  total: integer;
}

model FacultyExamNotificationRequest {
  @minLength(3)
  @example("Comunicazione appello")
  subject: string;

  @minLength(1)
  @example("Si comunica che l'appello si svolgerà in Aula 1P.")
  message: string;

  /** Canali di notifica da utilizzare. */
  channels?: ("push" | "email")[];
}

model FacultyAddExamEnrollmentRequest {
  @example("s123456")
  personId: string;

  @example("Studente fuori corso")
  note?: string | null;
}

/* INTERFACE */

@tag("Faculty - Exams")
@route("/faculty/exams")
interface FacultyExams {
  @get
  @summary("List exams | Elenco appelli del docente")
  @opExample(_ex_listFacultyExams_resp)
  listFacultyExams(
    @query courseId?: string,
    @query dateFrom?: plainDate,
    @query dateTo?: plainDate,
    @query page?: integer,
    @query pageSize?: integer,
  ): OkResponse<FacultyPaginatedExamList> | BaseErrors;

  @get
  @route("/{examId}")
  @summary("Exam detail with enrollments | Dettaglio appello con iscritti")
  @opExample(_ex_getFacultyExam_resp)
  getFacultyExam(@path examId: string): OkDataResponse<FacultyExam> | NotFound | BaseErrors;

  @post
  @route("/{examId}/notify")
  @summary("Send notification to enrolled students | Invia comunicazione agli iscritti")
  @opExample(_ex_notifyFacultyExamSubscribers_req)
  @opExample(_ex_notifyFacultyExamSubscribers_resp)
  notifyFacultyExamSubscribers(
    @path examId: string,
    @body body: FacultyExamNotificationRequest,
  ): AcceptedResponse | NotFound | BaseErrors;

  @post
  @route("/{examId}/enrollments")
  @summary("Add student to exam | Aggiungi studente all'esame")
  @opExample(_ex_addFacultyExamEnrollment_req)
  @opExample(_ex_addFacultyExamEnrollment_resp)
  addFacultyExamEnrollment(
    @path examId: string,
    @body body: FacultyAddExamEnrollmentRequest,
  ): OkDataCreatedResponse<FacultyExamEnrollment> | NotFound | Conflict | BaseErrors;
}
