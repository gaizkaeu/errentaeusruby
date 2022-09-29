import { Text,  Card, Link } from "@nextui-org/react"
import React from "react"
import { formatRelative } from "date-fns";
import { es } from "date-fns/locale"
import { Appointment } from "../../storage/types";


const AppointmentCard = (props: { appointment: Appointment }) => {

    return (
        <Card>
            <Card.Header>
                <Text b>{formatRelative(new Date(props.appointment.time), new Date(), { locale: es }).toLocaleUpperCase()}</Text>
            </Card.Header>
            <Card.Divider/>
            <Card.Body>
                <Text>{props.appointment.method == "phone" ? "Te llamaremos al telefono proporcionado" : "Te esperamos en nuestra oficina."} </Text>
                {props.appointment.method == "office" && <Link href="https://g.page/eliza-asesores?share">Indicaciones</Link>}
            </Card.Body>
        </Card>
    )
}


export default AppointmentCard;


