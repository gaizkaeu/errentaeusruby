import { Card, Spacer, Text } from "@nextui-org/react";
import { AppointmentWrapper } from "../../../Appointment/Appointment";
import { TaxIncome } from "../../../../storage/types";

const WaitingMeeting = (props: { taxIncome: TaxIncome }) => {
  return (
    <div>
      <AppointmentWrapper appointmentId={props.taxIncome.appointment} />
      <Spacer />
      <Card variant="flat">
        <Card.Header>
          <Text b size="$xl">
            Esperando para hablar contigo.
          </Text>
        </Card.Header>
        <Card.Divider />
        <Card.Body>Tenemos una cita contigo.</Card.Body>
      </Card>
    </div>
  );
};

export default WaitingMeeting;
