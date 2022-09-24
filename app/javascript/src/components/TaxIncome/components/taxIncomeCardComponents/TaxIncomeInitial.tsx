import React from "react"
import { Button, Card, Spacer, Text, User } from "@nextui-org/react"
import taxIncomeSlice, { setAppointmentToIncomeTax, TaxIncome } from "../../../../storage/taxIncomeSlice";
import LawyerAvatar from "../../../Lawyer";
import axios from "axios";
import { useAppDispatch } from "../../../../storage/hooks";
import AssignedLawyer from "../../../Lawyer/AssignedLawyer";

const TaxIncomeInitial = (props: {taxIncome: TaxIncome}) => {
    const {taxIncome} = props;
    const dispatch = useAppDispatch()
    return (
        <div>
        <Card>
            <Card.Header>
                <Text b color="success" size="$xl">¡Estamos listos!</Text>
            </Card.Header>
            <Card.Divider />
            <Card.Body>
                <Text>Tenemos que concertar una cita. Para asegurarnos que te damos el servicio que necesitas.</Text>
                <Text b size="lg">¿Cuándo te viene bien?</Text>
                <Button onPress={() => {
                    dispatch(setAppointmentToIncomeTax({id: taxIncome.id, time: new Date()}))
                }}>test</Button>
            </Card.Body>
        </Card>
        <Spacer/>
        <AssignedLawyer lawyer={taxIncome.lawyer!}/>
        </div>
    )
}

export default TaxIncomeInitial;