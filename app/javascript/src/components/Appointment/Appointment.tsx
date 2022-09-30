import { Text, Button, Input, Radio, Spacer, Card, Loading, Link } from "@nextui-org/react"
import React from "react"
import { useGetAppointmentByIdQuery } from "../../storage/api";
import { DayPicker } from "react-day-picker";
import { formatRelative } from "date-fns";
import {es} from "date-fns/locale"
import es_day from 'date-fns/locale/es';
import { Appointment } from "../../storage/types";

export const AppointmentWrapper = (props: { appointmentId: string }) => {
    const {currentData, isError, isLoading} = useGetAppointmentByIdQuery(props.appointmentId)

    return isLoading || !currentData || isError ?  <Loading type="points" /> : <Appointment appointment={currentData}/>

}


const Appointment = (props: { appointment: Appointment }) => {

    return (
        <Card variant="flat">
            <Card.Header>
                <div className="flex w-full">
                    <div className="flex-1">
                        <Text b>Mi cita - {formatRelative(new Date(props.appointment.time), new Date(), {locale: es})}</Text>
                    </div>
                </div>
            </Card.Header>
                <Card.Body>
                    <div className="flex flex-wrap">
                        <DayPicker locale={es_day} selected={new Date(props.appointment.time)}></DayPicker>
                        <Text>{props.appointment.method == "phone" ? "Te llamaremos al telefono proporcionado" : "Te esperamos en nuestra oficina."} </Text>
                        {props.appointment.method == "office" && <Link href="https://g.page/eliza-asesores?share">Indicaciones</Link>}
                    </div>
                </Card.Body>
        </Card>
    )
}


export default Appointment;


