import React from "react"
import { Card, Text } from "@nextui-org/react"

const TaxIncomeInitial = () => {
    return (
        <Card>
            <Card.Header>
                <Text b color="success" size="$xl">¡Estamos listos!</Text>
            </Card.Header>
            <Card.Divider/>
            <Card.Body>
                <Text>Tenemos que concertar una cita. Para asegurarnos que te damos el servicio que necesitas.</Text>
                <Text b size="lg">¿Cuándo te viene bien?</Text>
            </Card.Body>
        </Card>
    )
}

export default TaxIncomeInitial;