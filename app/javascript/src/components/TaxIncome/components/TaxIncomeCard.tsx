import { Text } from "@nextui-org/react";
import { TaxIncome } from "../../../storage/types";
import MeetingCreation from "./CardComponents/MeetingCreation";
import WaitingPayment from "./CardComponents/Payment";
import WaitingLawyer from "./CardComponents/WaitingLawyer";
import WaitingMeeting from "./CardComponents/WaitingMeeting";

const TaxIncomeCard = (props: {taxIncome: TaxIncome, renderCard?: string, navCurrentState: JSX.Element}) => {

    const {taxIncome} = props;

    const renderStatus = () => {
        let to_render = props.renderCard ?? props.taxIncome.state
        switch (to_render) {
            case "pending_assignation":
                return props.taxIncome.state == "pending_assignation" ? <WaitingLawyer/> : props.navCurrentState;
            case "waiting_for_meeting_creation":
                return  props.taxIncome.state == "waiting_for_meeting_creation" ? <MeetingCreation taxIncome={taxIncome}/> : props.navCurrentState;
            case "waiting_for_meeting":
                return <WaitingMeeting taxIncome={taxIncome}/>;
            case "waiting_payment":
                return props.taxIncome.state == "waiting_payment" ? <WaitingPayment taxIncome={taxIncome}/> : props.navCurrentState;
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