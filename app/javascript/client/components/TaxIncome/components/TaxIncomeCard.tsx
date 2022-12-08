import { Button, Card, Loading, Text } from "@nextui-org/react";
import { formatRelative } from "date-fns";
import es from "date-fns/locale/es";
import { t } from "i18next";
import { Navigate, useNavigate } from "react-router-dom";
import { useAuth } from "../../../hooks/authHook";
import { useGetTaxIncomesQuery } from "../../../storage/api";
import { TaxIncome } from "../../../storage/models/TaxIncome";
import { RandomColorText } from "../../../utils/GlobalStyles";
import { RightArrowIcon } from "../../Icons/RightArrowIcon";
import {
  AssignedUserSimple,
  AssignedLawyerSimple,
  LawyerSkeleton,
} from "../../Lawyer/AssignedLawyer";
import { SearchBar } from "../../Search";
import MeetingCreation from "./CardComponents/MeetingCreation";
import WaitingPayment, { PaymentCompleted } from "./CardComponents/Payment";
import DocumentationUpload from "./CardComponents/WaitingDocumentation";
import WaitingLawyer from "./CardComponents/WaitingLawyer";
import WaitingMeeting from "./CardComponents/WaitingMeeting";

export const TaxIncomeCardMinList = (props: { searchBar: boolean }) => {
  const { currentData, isError, isLoading } = useGetTaxIncomesQuery();

  return (
    <div className="grid grid-cols-1 gap-4">
      {props.searchBar && <SearchBar />}
      {isLoading || isError || !currentData ? (
        <Loading type="points" />
      ) : (
        currentData.map((v, ind) => {
          return <TaxIncomeCardMin taxIncome={v} key={ind} />;
        })
      )}
    </div>
  );
};

const TaxIncomeCardMin = (props: { taxIncome: TaxIncome }) => {
  const nav = useNavigate();
  const { currentUser } = useAuth();

  const { taxIncome } = props;

  return (
    <Card
      variant="flat"
      className="hover:transition-all shadow-lg hover:shadow-xl hover:rounded-xl hover:translate-y-1"
      css={{ backgroundColor: "$background", borderRadius: 8 }}
      isPressable
      onPress={() => nav(`/mytaxincome/${taxIncome.id}`)}
    >
      <Card.Header>
        <div className="flex w-full ">
          <div className="grow">
            <Text size="$xl" b>
              {t(`taxincome.statuses.${props.taxIncome.state}`)}
            </Text>
          </div>
          <div>
            <RandomColorText
              size="$2xl"
              value={props.taxIncome.year ?? 0}
              className="font-extrabold"
              b
            >
              {props.taxIncome.year}
            </RandomColorText>
          </div>
        </div>
      </Card.Header>
      <Card.Body>
        <div className="flex flex-wrap items-center">
          <div className="flex-1">
            {currentUser && currentUser.account_type == "lawyer" ? (
              <AssignedUserSimple userId={taxIncome.user} size={"md"} />
            ) : taxIncome.lawyer ? (
              <AssignedLawyerSimple lawyerId={taxIncome.lawyer} size={"md"} />
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
  lawyer: boolean;
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
        return (
          <DocumentationUpload taxIncome={taxIncome} lawyer={props.lawyer} />
        );
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
