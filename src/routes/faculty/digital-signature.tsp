import "@typespec/http";
import "@typespec/openapi3";

import "../../common.tsp";
import "../../examples/faculty/signature.tsp";

using Http;

namespace PolitoAPI;

enum FacultySignableDocumentStatus {
  pending,
  signed,
  rejected,
}

model FacultySignableDocument {
  @example("doc_001")
  id: string;

  @example("Verbale esame - Analisi Matematica I")
  title: string;

  @example(FacultySignableDocumentStatus.pending)
  status: FacultySignableDocumentStatus;

  @example(utcDateTime.fromISO("2024-03-15T10:00:00Z"))
  createdAt?: utcDateTime;

  @example(utcDateTime.fromISO("2024-03-20T23:59:59Z"))
  expiresAt?: utcDateTime | null;
}

model FacultySignDocumentRequest {
  @example("123456")
  otp?: string | null;
}

model FacultySignDocumentResponse {
  /** URL di redirezione al provider di firma (es. InfoCert). */
  @example("https://firma.infocert.it/sign/abc123")
  redirectUrl?: url | null;

  /** Stato della richiesta di firma. */
  @example("pending")
  status: string;
}

@tag("Faculty - Digital Signature")
@route("/faculty/signing")
interface FacultyDigitalSignature {
  @get
  @route("/documents")
  @summary("List documents to sign | Elenco documenti da firmare")
  @opExample(_ex_listFacultySignableDocuments_resp)
  listFacultySignableDocuments(
    /** Filtra per stato del documento. */
    @query status?: FacultySignableDocumentStatus,
  ): OkDataResponse<FacultySignableDocument[]> | BaseErrors;

  @post
  @route("/documents/{documentId}/sign")
  @summary("Start digital signature | Avvia firma digitale")
  @opExample(_ex_signFacultyDocument_resp)
  signFacultyDocument(
    @path documentId: string,
    @body body?: FacultySignDocumentRequest,
  ): OkDataResponse<FacultySignDocumentResponse> | NotFound | BaseErrors;
}
