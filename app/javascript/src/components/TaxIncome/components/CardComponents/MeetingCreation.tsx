import React from "react"
import { Card, Spacer, Text } from "@nextui-org/react"
import 'react-day-picker/dist/style.css';
import NewAppointmentForm from "../../../Appointment/NewAppointmentForm";
import { TaxIncome } from "../../../../storage/types";

const MeetingCreation = (props: { taxIncome: TaxIncome }) => {
    const { taxIncome } = props;
    return (
        <Card variant="flat">
            <Card.Header>
                <Text b color="success" size="$xl">¡Estamos listos!</Text>
            </Card.Header>
            <Card.Divider />
            <Card.Body>
                <Text>Tenemos que concertar una cita. Para asegurarnos que te damos el servicio que necesitas.</Text>
                <Spacer />
                <NewAppointmentForm taxIncomeId={taxIncome.id} />
            </Card.Body>
        </Card>
    )
}

export default MeetingCreation;