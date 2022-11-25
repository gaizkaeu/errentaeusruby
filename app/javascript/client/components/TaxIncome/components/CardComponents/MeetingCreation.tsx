import { Card, Spacer, Text } from "@nextui-org/react";
import NewAppointmentForm from "../../../Appointment/NewAppointment";
import { TaxIncome } from "../../../../storage/types";

const MeetingCreation = (props: { taxIncome: TaxIncome }) => {
  const { taxIncome } = props;
  return (
    <>
      <NewAppointmentForm taxIncomeId={taxIncome.id} />
      <Spacer y={2} />
      <Card variant="flat">
        <Card.Header>
          <Text b color="success" size="$xl">
            ¡Estamos listos!
          </Text>
        </Card.Header>
        <Card.Divider />
        <Card.Body>
          <Text>
            Tenemos que concertar una cita. Para asegurarnos que te damos el
            servicio que necesitas.
          </Text>
          <Spacer />
        </Card.Body>
      </Card>
    </>
  );
};

export default MeetingCreation;
