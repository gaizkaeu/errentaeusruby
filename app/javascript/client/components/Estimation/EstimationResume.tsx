import { Text, Textarea } from "@nextui-org/react";
import { Estimation } from "../../storage/types";
import EstimationCard from "./EstimationCard";

const SingleEstimation = (props: { estimation: Estimation }) => {
  return (
    <div className="grid grid-cols-1 gap-4">
      <div>
        <Text h2>Según tus respuestas</Text>
        <EstimationCard estimation={props.estimation} deletable />
      </div>
      <div>
        <Text h3>Compatir esta estimation</Text>
        <Textarea
          fullWidth
          readOnly
          initialValue={props.estimation.estimation_jwt}
        ></Textarea>
      </div>
    </div>
  );
};

export default SingleEstimation;
