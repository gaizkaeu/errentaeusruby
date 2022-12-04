import { Button, Card, Loading, Text } from "@nextui-org/react";
import { formatRelative } from "date-fns";
import es from "date-fns/locale/es";
import { Navigate, useNavigate } from "react-router-dom";
import { useAuth } from "../../../hooks/authHook";
import { useGetTaxIncomesQuery } from "../../../storage/api";
import { TaxIncome } from "../../../storage/models/TaxIncome";
import { RightArrowIcon } from "../../Icons/RightArrowIcon";
import {
  AssignedUserSimple,
  AssignedLawyerSimple,
  LawyerSkeleton,
} from "../../Lawyer/AssignedLawyer";
import MeetingCreation from "./CardComponents/MeetingCreation";
import WaitingPayment, { PaymentCompleted } from "./CardComponents/Payment";
import DocumentationUpload from "./CardComponents/WaitingDocumentation";
import WaitingLawyer from "./CardComponents/WaitingLawyer";
import WaitingMeeting from "./CardComponents/WaitingMeeting";

export const TaxIncomeCardMinList = () => {
  const { currentData, isError, isLoading } = useGetTaxIncomesQuery();

  return (
    <div className="grid grid-cols-1 gap-4">
      {isLoading || isError || !currentData ? (
        <Loading type="points" />
      ) : (
        currentData.map((v, ind) => {
          return <TaxIncomeCardMin taxIncome={v} key={ind}></TaxIncomeCardMin>;
        })
      )}
    </div>
  );
};

const TaxIncomeCardMin = (props: { taxIncome: TaxIncome }) => {
  const nav = useNavigate();
  const { currentUser } = useAuth();

  const { taxIncome } = props;

  const renderStatus = () => {
    switch (taxIncome.state) {
      case "pending_assignation":
        return <Text b>Te estamos asignando un asesor</Text>;
      case "waiting_for_meeting_creation":
        return <Text b>Pendiente cita</Text>;
      case "waiting_for_meeting":
        return <Text b>Esperando a la cita</Text>;
      case "waiting_payment":
        return <Text b>Esperando pago</Text>;
      case "pending_documentation":
        return <Text b>Esperando documentación</Text>;
      case "in_progress":
        return <Text b>In progress</Text>;
      case "finished":
        return <Text b> finished</Text>;
      case "rejected":
        return <Text b>rejected</Text>;
      default:
        return <Text> No sabemos que ha pasado</Text>;
    }
  };

  return (
    <Card
      variant="flat"
      className="shadow-lg hover:shadow-xl"
      css={{ backgroundColor: "$background" }}
      isPressable
      onPress={() => nav(`/mytaxincome/${taxIncome.id}`)}
    >
      <Card.Header>{renderStatus()}</Card.Header>
      <Card.Divider />
      <Card.Body>
        <div className="flex flex-wrap items-center">
          <div className="flex-1">
            {currentUser && currentUser.account_type == "lawyer" ? (
              <AssignedUserSimple userId={taxIncome.user} size={"md"} />
            ) : taxIncome.lawyer ? (
              <AssignedLawyerSimple lawyerId={taxIncome.lawyer} size={"xs"} />
            ) : (
              <LawyerSkeleton />
            )}
          </div>
          <Button
            auto
            color="warning"
            rounded
            aria-label="show tax income"
            onPress={() => nav(`/mytaxincome/${taxIncome.id}`)}
            iconRight={
              <RightArrowIcon
                filled
                fill="currentColor"
                height={24}
                width={24}
                label="Ir a la estimación"
              />
            }
          />
        </div>
      </Card.Body>
      <Card.Divider />
      <Card.Footer>
        <Text weight="light" size="sm">
          Última actualizacion{" "}
          {formatRelative(new Date(taxIncome.updated_at), new Date(), {
            locale: es,
          })}
        </Text>
      </Card.Footer>
    </Card>
  );
};

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
