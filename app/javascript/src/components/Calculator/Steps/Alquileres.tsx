import { Fragment } from "react";
import YesNoField from "../../FormFields/YesNoField";
import InputField from "../../FormFields/InputField";
import { FieldData } from "../Model/calculatorFormModel";

export default function Alquileres(props: {
  formField: {
    rentalsMortgagesQ: FieldData;
    rentalsMortgagesNum: FieldData;
  };
}) {
  const {
    formField: { rentalsMortgagesNum, rentalsMortgagesQ },
  } = props;
  return (
    <Fragment>
      <YesNoField showOn={1} name={rentalsMortgagesQ.name} conditionalRender>
        <InputField
          name={rentalsMortgagesNum.name}
          label={rentalsMortgagesQ.label}
          rounded
          bordered
          fullWidth
        ></InputField>
      </YesNoField>
    </Fragment>
  );
}
