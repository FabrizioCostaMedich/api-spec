import "@typespec/http";
import "@typespec/openapi3";

import "../../common.tsp";
import "../../examples/courses.tsp";

using Http;
using OpenAPI;

namespace PolitoAPI;

@tag("Lectures")
@route("/lectures")
interface Lectures {
  @get
  @summary("List lectures | Elenca lezioni")
  @opExample(_ex_getLectures_resp)
  getLectures(
    /** First day - defaults to 7 days before today */
    @query fromDate?: plainDate,

    /** Last day - defaults to 7 days after today */
    @query toDate?: plainDate,

    /** Only include lectures belonging to these courses */
    @query(#{ explode: true }) `courseIds[]`?: numeric[],
  ): OkDataResponse<Lecture[]> | BaseErrors;
}
