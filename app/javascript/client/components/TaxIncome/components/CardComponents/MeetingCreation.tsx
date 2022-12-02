import { TaxIncome } from "../../../../storage/models/TaxIncome";
import NewAppointmentForm from "../../../Appointment/NewAppointment";

const MeetingCreation = (props: { taxIncome: TaxIncome }) => {
  const { taxIncome } = props;
  return (
    <>
      <NewAppointmentForm taxIncomeId={taxIncome.id} />
    </>
  );
};

export default MeetingCreation;
