import React from "react";
import { Text } from "@nextui-org/react";
import { TaxIncome } from "../../../storage/taxIncomeSlice";
import TaxIncomeInitial from "./taxIncomeCardComponents/TaxIncomeInitial";
import TaxIncomeWaitingMeeting from "./taxIncomeCardComponents/TaxIncomeWaitingMeeting";


const TaxIncomeCard = (props: {taxIncome: TaxIncome}) => {

    const {taxIncome} = props;

    const renderStatus = () => {
        switch (taxIncome.state) {
            case "pending_assignation":
                return <Text>Te estamos asignando un asesor</Text>
            case "waiting_for_meeting_creation":
                return <TaxIncomeInitial taxIncome={taxIncome}/>;
            case "waiting_for_meeting":
                return <TaxIncomeWaitingMeeting taxIncome={taxIncome}/>;
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