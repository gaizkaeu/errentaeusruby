import { Fragment } from "react";
import { HeaderMin } from "../components/Header";
import { useSearchParams } from "react-router-dom";
import ContinueEstimation, {
  SingleEstimation,
} from "../components/Estimation/ResumePage/ContinueEstimation";
import { InputEstimation } from "../components/Estimation/ResumePage/InputEstimation";
import { useGetEstimationByTokenQuery } from "../storage/api";

function EstimationPage() {
  const [searchParams] = useSearchParams();
  const { data, isLoading, isError } = useGetEstimationByTokenQuery(
    searchParams.get("j") ?? "",
    { skip: searchParams.get("j") ? false : true }
  );

  return (
    <Fragment>
      <HeaderMin
        gradient="45deg, $blue600 -20%, $pink600 50%"
        title="estimation.title"
        subtitle="estimation.subtitle"
      />
      <main className="px-4 mx-auto max-w-7xl lg:px-8">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-10">
          {data && !isLoading && !isError ? (
            <>
              <ContinueEstimation estimation={data} />
              <SingleEstimation estimation={data} />
            </>
          ) : (
            <InputEstimation />
          )}
        </div>
      </main>
    </Fragment>
  );
}

export default EstimationPage;
