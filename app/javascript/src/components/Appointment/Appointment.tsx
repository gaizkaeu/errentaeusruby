import { Text, Button, Input, Radio, Spacer, Card, Loading } from "@nextui-org/react"
import React from "react"
import { useGetAppointmentByIdQuery } from "../../storage/api";
import { DayPicker } from "react-day-picker";
import { formatRelative } from "date-fns";
import {es} from "date-fns/locale"
import es_day from 'date-fns/locale/es';


const Appointment = (props: { appointmentId: string }) => {

    const {currentData, isError, isLoading} = useGetAppointmentByIdQuery(props.appointmentId)

    return (
        <Card>
            <Card.Header>
                <div className="flex w-full">
                    <div className="flex-1">
                        <Text b>Mi cita</Text>
                    </div>
                    <Button size="sm">Editar</Button>
                </div>
            </Card.Header>
            {isLoading || !currentData || isError ?  <Loading type="points" /> : (
                <Card.Body>
                    <div className="flex flex-wrap">
                        <DayPicker locale={es_day} selected={new Date(currentData!.time)}></DayPicker>
                        <Text>{formatRelative(new Date(currentData!.time), new Date(), {locale: es})}</Text>
                    </div>
                </Card.Body>
            )}
        </Card>
    )
}


export default Appointment;


