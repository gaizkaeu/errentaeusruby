import NewAppointmentForm from "../../../Appointment/NewAppointment";
import { TaxIncome } from "../../../../storage/types";

const MeetingCreation = (props: { taxIncome: TaxIncome }) => {
  const { taxIncome } = props;
  return (
    <>
      <NewAppointmentForm taxIncomeId={taxIncome.id} />
    </>
  );
};

export default MeetingCreation;
