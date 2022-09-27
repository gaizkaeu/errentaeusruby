import React from "react"
import { Button, Card, Spacer, Text, User } from "@nextui-org/react"
import Appointment from "../../../Appointment/Appointment";
import { TaxIncome } from "../../../../storage/types";

const WaitingMeeting = (props: { taxIncome: TaxIncome }) => {
    const { taxIncome } = props;
    return (
        <div>
            <Card>
                <Card.Header>
                    <Text b size="$xl">Esperando para hablar contigo.</Text>
                </Card.Header>
                <Card.Divider />
                <Card.Body>
                    Tenemos una cita contigo.
                </Card.Body>
            </Card>
            <Spacer/>
            <Appointment appointmentId={taxIncome.appointment!}></Appointment>
        </div>
    )
}

export default WaitingMeeting;