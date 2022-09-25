import { Text, Button, Input, Radio, Spacer, Card } from "@nextui-org/react"
import React from "react"
import { useAppDispatch } from "../../storage/hooks";
import { IAppointment } from "../../storage/taxIncomeSlice";
import {  utcToZonedTime } from "date-fns-tz";


const Appointment = (props: { appointment: IAppointment }) => {
     const dispatch = useAppDispatch();

    return (
        <Card>
            <Card.Header>Cita con d </Card.Header>
            <Card.Body>
                {utcToZonedTime(props.appointment.time, 'Europe/Madrid').toString()}
            </Card.Body>
        </Card>
    )
}


export default Appointment;


