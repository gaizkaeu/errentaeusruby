import { Fragment, useEffect } from "react";
import { useAppSelector } from "../storage/hooks";
import { HeaderMin } from "../components/Header";
import { useSearchParams } from "react-router-dom";
import { toast } from "react-hot-toast";

const SingleEstimation = React.lazy(
  () => import("../components/Estimation/EstimationResume")
);
const ContinueEstimation = React.lazy(
  () => import("../components/Estimation/ContinueEstimation")
);

function EstimationPage() {
  const [searchParams, setSearchParams] = useSearchParams();
  const estimations = useAppSelector((state) => state.estimations.estimation);

  useEffect(() => {
    const params = new URLSearchParams(searchParams);
    if (estimations) {
      params.set("j", estimations.estimation_jwt);
    } else {
      if (params.get("j")) {
        toast.success("recalculado..");
      }
    }
    setSearchParams(params);
  }, []);

  return (
    <Fragment>
      <HeaderMin
        gradient="45deg, $blue600 -20%, $pink600 50%"
        title="estimation.title"
        subtitle="estimation.subtitle"
      />
      <main className="px-4 mx-auto max-w-7xl lg:px-8">
        {/* {estimations ? ( */}
        <div className="grid items-center grid-cols-1 lg:grid-cols-2 gap-10 self-center">
          {estimations && <SingleEstimation estimation={estimations} />}
          <ContinueEstimation />
        </div>
        {/* ) : (
          <Navigate to="/calculator" replace></Navigate>
        )} */}
      </main>
    </Fragment>
  );
}

export default EstimationPage;
