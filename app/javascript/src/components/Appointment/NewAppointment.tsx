import AppointmentForm from "./AppointmentForm";
import { useAppointment } from "../../hooks/useAppointment";

const NewAppointment = (props: { taxIncomeId: string }) => {
  const { appointment } = useAppointment("undefined", props.taxIncomeId);

  return <AppointmentForm onSubmit={appointment.newFormSubmit} />;
};

export default NewAppointment;
