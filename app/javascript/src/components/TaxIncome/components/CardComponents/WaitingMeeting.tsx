import React from "react"
import {  Card, Spacer, Text } from "@nextui-org/react"
import {AppointmentWrapper } from "../../../Appointment/Appointment";
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
            <AppointmentWrapper appointmentId={taxIncome.appointment!}></AppointmentWrapper>
        </div>
    )
}

export default WaitingMeeting;