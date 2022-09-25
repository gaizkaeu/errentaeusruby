import React from "react"
import { Card, Spacer, Text } from "@nextui-org/react"
import { TaxIncome } from "../../../../storage/taxIncomeSlice";
import 'react-day-picker/dist/style.css';
import NewAppointmentForm from "../../../Appointment/NewAppointmentForm";

const TaxIncomeInitial = (props: { taxIncome: TaxIncome }) => {
    const { taxIncome } = props;
    return (
        <div>
            <Card>
                <Card.Header>
                    <Text b color="success" size="$xl">¡Estamos listos!</Text>
                </Card.Header>
                <Card.Divider />
                <Card.Body>
                    <Text>Tenemos que concertar una cita. Para asegurarnos que te damos el servicio que necesitas.</Text>
                    <Spacer/>
                    <NewAppointmentForm tax_id={taxIncome.id}/> 
                </Card.Body>
            </Card>
            <Spacer />
        </div>
    )
}

export default TaxIncomeInitial;