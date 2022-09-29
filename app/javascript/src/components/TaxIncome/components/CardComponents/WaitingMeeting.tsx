import React from "react"
import { Card, Text } from "@nextui-org/react"

const WaitingMeeting = () => {
    return (
        <Card variant="flat">
            <Card.Header>
                <Text b size="$xl">Esperando para hablar contigo.</Text>
            </Card.Header>
            <Card.Divider />
            <Card.Body>
                Tenemos una cita contigo.
            </Card.Body>
        </Card>
    )
}

export default WaitingMeeting;