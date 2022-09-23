import React from "react";
import { Card, Text } from "@nextui-org/react";
import taxIncomeSlice, { TaxIncome } from "../../../storage/taxIncomeSlice";
import TaxIncomeInitial from "./taxIncomeCardComponents/TaxIncomeInitial";


const TaxIncomeCard = (props: {taxIncome: TaxIncome}) => {

    const {taxIncome} = props;

    const renderStatus = () => {
        switch (taxIncome.state) {
            case "initial":
                return <TaxIncomeInitial/>;
            case "pending_meeting":
                return <Text>Peding meeting</Text>;
            case "pending_documentation":
                return <Text>Peding documentation</Text>;
            case "in_progress":
                return <Text>In progress</Text>;
            case "finished":
                return <Text> finished</Text>;
            case "rejected":
                return <Text>rejected</Text>;
            default:
                return <Text> No sabemos que ha pasado</Text>        
            
        }
    }

    return (
        renderStatus()
    )
}

export default TaxIncomeCard;