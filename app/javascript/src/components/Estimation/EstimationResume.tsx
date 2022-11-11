import { Text } from "@nextui-org/react";
import { Estimation } from "../../storage/types";
import EstimationCard from "./EstimationCard";

const SingleEstimation = (props: { estimation: Estimation }) => {
  return (
    <div>
      <Text h2>Según tus respuestas</Text>
      <EstimationCard estimation={props.estimation} deletable />
    </div>
  );
};

export default SingleEstimation;
