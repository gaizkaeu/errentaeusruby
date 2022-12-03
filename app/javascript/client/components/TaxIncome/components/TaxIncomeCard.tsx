import { Text } from "@nextui-org/react";
import { Navigate } from "react-router-dom";
import { TaxIncome } from "../../../storage/models/TaxIncome";
import MeetingCreation from "./CardComponents/MeetingCreation";
import WaitingPayment, { PaymentCompleted } from "./CardComponents/Payment";
import DocumentationUpload from "./CardComponents/WaitingDocumentation";
import WaitingLawyer from "./CardComponents/WaitingLawyer";
import WaitingMeeting from "./CardComponents/WaitingMeeting";

const TaxIncomeCard = (props: {
  taxIncome: TaxIncome;
  renderCard?: string;
  navCurrentState: JSX.Element;
}) => {
  const { taxIncome } = props;

  const renderStatus = () => {
    const to_render = props.renderCard ?? taxIncome.state;

    switch (to_render) {
      case "pending_assignation":
        return taxIncome.state == "pending_assignation" ? (
          <WaitingLawyer />
        ) : (
          props.navCurrentState
        );
      case "waiting_for_meeting_creation":
        return taxIncome.state == "waiting_for_meeting_creation" ? (
          <MeetingCreation taxIncome={taxIncome} />
        ) : (
          props.navCurrentState
        );
      case "waiting_for_meeting":
        return <WaitingMeeting taxIncome={taxIncome} />;
      case "waiting_payment":
        return taxIncome.state == "waiting_payment" ? (
          <WaitingPayment taxIncome={taxIncome} />
        ) : (
          <Navigate
            to={`/mytaxincome/${taxIncome.id}/payment_completed`}
            replace={true}
          />
        );
      case "refunded":
      case "payment_completed":
        return <PaymentCompleted taxIncome={taxIncome} />;
      case "pending_documentation":
        return <DocumentationUpload taxIncome={taxIncome} />;
      case "in_progress":
        return <Text>In progress</Text>;
      case "finished":
        return <Text> finished</Text>;
      case "rejected":
        return <Text>rejected</Text>;
      default:
        return <Text> No sabemos que ha pasado</Text>;
    }
  };

  return renderStatus();
};

export default TaxIncomeCard;
