import "@typespec/http";
import "@typespec/openapi3";

import "../../common.tsp";
import "../../examples/faculty-courses.tsp";

using Http;

namespace PolitoAPI;

model FacultyCourseEdition {
  @example("2024")
  year: string;

  @example(251007)
  id: integer;
}

model FacultyCourseOverview {
  @example(251007)
  id: integer;

  @example("System and device programming")
  name: string;

  @example("01NYHOV")
  shortcode: string;

  @example(10)
  cfu: integer;

  @example("2-2")
  teachingPeriod?: string;

  @example(2893)
  teacherId?: integer | null;

  previousEditions?: FacultyCourseEdition[];

  @example(false)
  isModule?: boolean;

  @example("2025")
  year?: string;

  moodleCourses?: {
    name?: string;
    id?: string;
  }[] | null;
}

model FacultyCourseStudent {
  @example("s123456")
  id: string;

  @example("Mario")
  firstName: string;

  @example("Rossi")
  lastName: string;

  @example("s123456")
  username: string;

  picture?: {
    url: url;
  };
}

model FacultyAssignmentSubmission {
  @example("asn_001")
  id: string;

  @example("Laboratorio 3")
  title: string;

  @example(utcDateTime.fromISO("2024-03-15T14:00:00Z"))
  publishedAt: utcDateTime;

  @example("s123456")
  submittedBy: string;
}

model FacultyLectureStaffMember {
  @example("p001")
  personId: string;

  @example("Mario Rossi")
  name: string;

  @example(FacultyLectureStaffRole.OWNER)
  role: FacultyLectureStaffRole;
}

enum FacultyLectureStaffRole {
  OWNER,
  COLLABORATOR,
}

model FacultyLecture {
  @example("lec_001")
  id: string;

  @example("251007")
  courseId: string;

  @example("Lezione 1 - Introduzione")
  title: string;

  @example("LECTURE")
  type: string;

  @example(utcDateTime.fromISO("2024-03-15T10:00:00Z"))
  startsAt: utcDateTime;

  @example(utcDateTime.fromISO("2024-03-15T12:00:00Z"))
  endsAt: utcDateTime;

  topic?: string | null;
  language?: string | null;
  room?: PlaceRef;
  staff: FacultyLectureStaffMember[];
}

model FacultyLectureStaffMemberRequest {
  personId: string;
  role: FacultyLectureStaffRole;
}

model FacultyLectureCreateRequest {
  title: string;
  type: string;
  startsAt: utcDateTime;
  endsAt: utcDateTime;
  topic?: string | null;
  language?: string | null;
  room?: PlaceRef;
  staff: FacultyLectureStaffMemberRequest[];
}

model FacultyLectureUpdateRequest {
  title?: string;
  type?: string;
  startsAt?: utcDateTime;
  endsAt?: utcDateTime;
  topic?: string | null;
  language?: string | null;
  room?: PlaceRef;
  staff?: FacultyLectureStaffMemberRequest[];
}

model FacultyPaginatedLectureList {
  data: FacultyLecture[];

  @example(1)
  page: integer;

  @example(20)
  pageSize: integer;

  @example(100)
  total: integer;
}

model FacultyCollaborator {
  @example("p002")
  personId: string;

  @example("Luigi Verdi")
  name: string;

  @example("Collaborator")
  role: string;

  courses?: string[];
  permissions: FacultyCollaboratorPermission[];
}

enum FacultyCollaboratorPermission {
  CAN_READ,
  CAN_EDIT,
  CAN_DELETE,
}

model FacultyCollaboratorUpsertRequest {
  personId: string;
  role?: string;
  permissions: FacultyCollaboratorPermission[];
}

model FacultyCollaboratorPermissionsRequest {
  personId: string;
  permissions: FacultyCollaboratorPermission[];
}

@tag("Faculty - Courses")
@route("/faculty/courses")
interface FacultyCourses {
  @get
  @summary("List courses | Elenca corsi docenti")
  @opExample(_ex_getFacultyCourses_resp)
  getFacultyCourses(): OkDataResponse<FacultyCourseOverview[]> | BaseErrors;

  @get
  @route("/{courseId}")
  @summary("Course detail | Dettaglio corso")
  @opExample(_ex_getFacultyCourse_resp)
  getFacultyCourse(
    @path courseId: integer,
  ): OkDataResponse<FacultyCourseOverview> | NotFound | BaseErrors;

  @get
  @route("/{courseId}/students")
  @summary("List enrolled students | Elenca studenti iscritti al corso")
  @opExample(_ex_listFacultyCourseStudents_resp)
  listFacultyCourseStudents(
    @path courseId: integer,
  ): OkDataResponse<FacultyCourseStudent[]> | NotFound | BaseErrors;

  @get
  @route("/{courseId}/assignments")
  @summary("List student assignments | Elenca elaborati caricati dagli studenti")
  @opExample(_ex_listFacultyCourseAssignments_resp)
  listFacultyCourseAssignments(
    @path courseId: integer,
  ): OkDataResponse<FacultyAssignmentSubmission[]> | NotFound | BaseErrors;

  @delete
  @route("/{courseId}/assignments/{assignmentId}")
  @summary("Delete student assignment | Rimuovi elaborato studente")
  deleteFacultyCourseAssignment(
    @path courseId: integer,
    @path assignmentId: string,
  ): NoContentResponse | NotFound | BaseErrors;

  @get
  @route("/{courseId}/collaborators")
  @summary("List collaborators | Elenca collaboratori assegnati al corso")
  listFacultyCourseCollaborators(
    @path courseId: integer,
  ): OkDataResponse<FacultyCollaborator[]> | NotFound | BaseErrors;

  @post
  @route("/{courseId}/collaborators")
  @summary("Add collaborator | Aggiungi collaboratore al corso")
  addFacultyCourseCollaborator(
    @path courseId: integer,
    @body body: FacultyCollaboratorUpsertRequest,
  ): OkDataCreatedResponse<FacultyCollaborator> | NotFound | BaseErrors;

  @delete
  @route("/{courseId}/collaborators/{collaboratorId}")
  @summary("Remove collaborator | Rimuovi collaboratore dal corso")
  removeFacultyCourseCollaborator(
    @path courseId: integer,
    @path collaboratorId: string,
  ): NoContentResponse | NotFound | BaseErrors;

  @patch(#{ implicitOptionality: true })
  @route("/{courseId}/collaborators/{collaboratorId}/permissions")
  @summary("Update collaborator permissions | Aggiorna permessi collaboratore")
  updateFacultyCourseCollaboratorPermissions(
    @path courseId: integer,
    @path collaboratorId: string,
    @body body: FacultyCollaboratorPermissionsRequest,
  ): OkDataResponse<FacultyCollaborator> | NotFound | BaseErrors;
}

@tag("Faculty - Lectures")
@route("/faculty/courses/{courseId}/lectures")
interface FacultyLectures {
  @get
  @summary("List lectures | Elenca lezioni del corso")
  listFacultyLectures(
    @path courseId: integer,
    @query page?: integer,
    @query pageSize?: integer,
  ): OkResponse<FacultyPaginatedLectureList> | NotFound | BaseErrors;

  @post
  @summary("Create lecture | Crea una lezione")
  createFacultyLecture(
    @path courseId: integer,
    @body body: FacultyLectureCreateRequest,
  ): OkDataCreatedResponse<FacultyLecture> | NotFound | BaseErrors;

  @get
  @route("/{lectureId}")
  @summary("Lecture detail | Dettaglio lezione")
  getFacultyLecture(
    @path courseId: integer,
    @path lectureId: string,
  ): OkDataResponse<FacultyLecture> | NotFound | BaseErrors;

  @patch(#{ implicitOptionality: true })
  @route("/{lectureId}")
  @summary("Update lecture | Aggiorna una lezione")
  updateFacultyLecture(
    @path courseId: integer,
    @path lectureId: string,
    @body body: FacultyLectureUpdateRequest,
  ): OkDataResponse<FacultyLecture> | NotFound | BaseErrors;

  @delete
  @route("/{lectureId}")
  @summary("Delete lecture | Elimina una lezione")
  deleteFacultyLecture(
    @path courseId: integer,
    @path lectureId: string,
  ): NoContentResponse | NotFound | BaseErrors;
}
