import "@typespec/http";
import "@typespec/openapi3";

import "../../common.tsp";
import "../../examples/student.tsp";

using Http;

namespace PolitoAPI;

model ProvisionalGrade {
  @example(654632)
  id: numeric;

  @example(887981)
  examId: numeric;

  @example("01NYHOV")
  courseShortcode: string;

  @example("System and device programming")
  courseName: string;

  @example(2893)
  teacherId: integer;

  @example(10)
  credits: numeric;

  @example("30")
  grade: string;

  @example(plainDate.fromISO("2022-07-15"))
  date: plainDate;

  @example("published")
  state: "published" | "confirmed" | "rejected";

  @example("Pubblicata")
  stateDescription: string;

  teacherMessage: string | null;

  @example(false)
  isWithdrawn: boolean;

  @example(false)
  isFailure: boolean;

  @example(true)
  canBeAccepted: boolean;

  @example(true)
  canBeRejected: boolean;

  confirmedAt: plainDate | null;
  rejectedAt: utcDateTime | null;

  @example(utcDateTime.fromISO("2022-07-31T23:59:59Z"))
  rejectingExpiresAt: utcDateTime;
}

model ProvisionalGradeState {
  @example("published")
  id: string;

  @example("Pubblicata")
  name: string;

  @example("La valutazione è stata pubblicata dal docente")
  description: string;
}

model ExamGrade {
  @example("System and device programming")
  courseName: string;

  @example(10)
  credits: numeric;

  @example("30L")
  grade: string;

  @example(plainDate.fromISO("2022-07-15"))
  date: plainDate;

  @example(2893)
  teacherId: integer | null;

  /** Points for "on-time" exams - null the student is not eligible for on-time exams or the exam does not grant on-time points */
  @example(2)
  onTimeExamPoints: numeric | null;

  @example("01NYHOV")
  shortcode: string;

  @example(2021)
  academicYear: integer;

  /** Defines whether the credits from the exam count toward the total required for graduation */
  @example(true)
  creditsCountTowardsDegree: boolean;
}

model Student {
  @example("s290683")
  username: string;

  @example("Luca")
  firstName: string;

  @example("Pezzolla")
  lastName: string;

  @example("active")
  status: "active" | "closed" | "cancelled" | "graduated" | "career_closed";

  /** All the ids related to this student */
  @example(#["290683", "213956"])
  allCareerIds: string[];

  @example("81-6")
  degreeId: string;

  @example("LM-32")
  degreeCode: string;

  @example("Corso di Laurea Magistrale in")
  degreeLevel: string;

  @example("INGEGNERIA INFORMATICA (COMPUTER ENGINEERING)")
  degreeName: string;

  @example(2021)
  firstEnrollmentYear: integer;

  @example(2022)
  lastEnrollmentYear: integer;

  @example(false)
  isCurrentlyEnrolled: boolean;

  @example(27.5)
  averageGrade: numeric | null;

  @example(105)
  estimatedFinalGrade: numeric | null;

  /** Purged grade is only available for bachelor degree students */
  averageGradePurged: numeric | null;

  /** Purged grade is only available for bachelor degree students */
  estimatedFinalGradePurged: numeric | null;

  /** Specify whether to use purgedAverageFinalGrade or averageFinalGrade as the graduation grade shown */
  usePurgedAverageFinalGrade: boolean;

  /** Master's admission grade is only available for bachelor degree students */
  mastersAdmissionAverageGrade: numeric | null;

  /** Total points for "on-time" exams - null if "on-time" exams are not applicable for the student's position (max value = maxOnTimeExamPoints) */
  totalOnTimeExamPoints: numeric | null;

  /** Maximum points for "on-time" exams */
  maxOnTimeExamPoints: numeric;

  /** Credits excluded from calculating the purged grade */
  excludedCreditsNumber: numeric | null;

  totalCredits: integer;
  totalAttendedCredits: integer;
  totalAcquiredCredits: integer;
  enrollmentCredits: integer;
  enrollmentAttendedCredits: integer;
  enrollmentAcquiredCredits: integer;
  smartCardPicture: string | null;
  europeanStudentCard: EuropeanStudentCard;
}

@tag("Student")
interface StudentNs {
  @route("/me")
  @get
  @summary("Retrieve student profile | Recupera il profilo studente")
  getStudent(): OkDataResponse<Student> | BaseErrors;

  @route("/grades")
  @get
  @summary("Retrieve student grades | Recupera i voti dello studente")
  getStudentGrades(): OkDataResponse<ExamGrade[]> | BaseErrors;
}

@tag("Student")
@route("/provisional-grades")
interface ProvisionalGrades {
  @get
  @summary("Retrieve student provisional grades | Recupera le valutazioni provvisorie dello studente")
  getStudentProvisionalGrades(): OkResponse<{
    data: ProvisionalGrade[];
    states: ProvisionalGradeState[];
  }> | BaseErrors;

  @route("/{provisionalGradeId}/accept")
  @post
  @summary("Accept provisional grade | Accetta valutazione provvisoria")
  acceptProvisionalGrade(
    @path provisionalGradeId: integer,
  ): NoContentResponse | BaseErrors;

  @route("/{provisionalGradeId}/reject")
  @post
  @summary("Reject provisional grade | Rifiuta valutazione provvisoria")
  rejectProvisionalGrade(
    @path provisionalGradeId: integer,
  ): NoContentResponse | BaseErrors;
}
