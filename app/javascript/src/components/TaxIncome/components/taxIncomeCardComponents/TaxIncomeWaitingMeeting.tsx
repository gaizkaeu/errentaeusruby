import React from "react"
import { Button, Card, Spacer, Text, User } from "@nextui-org/react"
import taxIncomeSlice, { setAppointmentToIncomeTax, TaxIncome } from "../../../../storage/taxIncomeSlice";
import LawyerAvatar from "../../../Lawyer";
import axios from "axios";
import { useAppDispatch } from "../../../../storage/hooks";
import AssignedLawyer from "../../../Lawyer/AssignedLawyer";
import Appointment from "../../../Appointment/Appointment";

const TaxIncomeWaitingMeeting = (props: { taxIncome: TaxIncome }) => {
    const { taxIncome } = props;
    const dispatch = useAppDispatch()
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
            {taxIncome.appointment?.time && <Appointment appointment={taxIncome.appointment}></Appointment>}
        </div>
    )
}

export default TaxIncomeWaitingMeeting;