import { MagnifyingGlassCircleIcon } from "@heroicons/react/24/outline";
import {
  Button,
  Card,
  Dropdown,
  Input,
  Loading,
  Modal,
  Text,
} from "@nextui-org/react";
import { formatRelative } from "date-fns";
import es from "date-fns/locale/es";
import { t } from "i18next";
import { Suspense, useState } from "react";
import { Navigate, useNavigate } from "react-router-dom";
import { useAuth } from "../../../hooks/authHook";
import { useGetTaxIncomesQuery } from "../../../storage/api";
import {
  TaxIncome,
  TaxIncomeSearchKeys,
} from "../../../storage/models/TaxIncome";
import { RightArrowIcon } from "../../Icons/RightArrowIcon";
import {
  AssignedUserSimple,
  AssignedLawyerSimple,
  LawyerSkeleton,
} from "../../Lawyer/AssignedLawyer";
import { ShowTaxIncomeSkeleton } from "../pages/ShowTaxIncome";
import MeetingCreation from "./CardComponents/MeetingCreation";
import WaitingPayment, { PaymentCompleted } from "./CardComponents/Payment";
import DocumentationUpload from "./CardComponents/WaitingDocumentation";
import WaitingLawyer from "./CardComponents/WaitingLawyer";
import WaitingMeeting from "./CardComponents/WaitingMeeting";

export const SearchBar = () => {
  const [visible, setVisible] = useState(false);
  const [selected, setSelected] = React.useState(TaxIncomeSearchKeys[0]);

  const handler = () => setVisible(true);
  const closeHandler = () => {
    setVisible(false);
  };

  return (
    <div className="flex gap-4 flex-wrap">
      <div className="grow flex gap-2">
        <Dropdown>
          <Dropdown.Button flat color="secondary" css={{ tt: "capitalize" }}>
            {selected}
          </Dropdown.Button>
          <Dropdown.Menu
            aria-label="Single selection actions"
            color="secondary"
            disallowEmptySelection
            selectionMode="single"
            selectedKeys={selected}
            onSelectionChange={setSelected}
          >
            {TaxIncomeSearchKeys.map((val) => {
              return <Dropdown.Item key={val}>{val}</Dropdown.Item>;
            })}
          </Dropdown.Menu>
        </Dropdown>
        <Input fullWidth placeholder="Gaizka" type="search" />
      </div>
      <Button
        auto
        onPress={handler}
        icon={<MagnifyingGlassCircleIcon height="20px" />}
      >
        <span className="hidden md:inline">Avanzado</span>
      </Button>
      <Modal
        closeButton
        aria-labelledby="modal-title"
        open={visible}
        onClose={closeHandler}
      >
        <Modal.Header>
          <Text id="modal-title" size={18}>
            {t("taxincome.actions.delete.modalTitle")}
          </Text>
        </Modal.Header>
        <Modal.Body>
          <Text>{t("taxincome.actions.delete.disclaimer")}</Text>
        </Modal.Body>
        <Modal.Footer>
          <Button auto flat color="error">
            {t("taxincome.actions.delete.confirmButton")}
          </Button>
          <Button auto onClick={closeHandler}>
            {t("taxincome.actions.delete.cancel")}
          </Button>
        </Modal.Footer>
      </Modal>
    </div>
  );
};

export const TaxIncomeCardMinList = (props: { searchBar: boolean }) => {
  const { currentData, isError, isLoading } = useGetTaxIncomesQuery({
    name: "asd",
  });

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
      className="hover:transition-all shadow-lg hover:shadow-xl hover:rounded-xl"
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
            <Text
              size="$2xl"
              className="font-extrabold"
              b
              css={{ textGradient: "45deg, $blue600 -20%, $pink600 50%" }}
            >
              {props.taxIncome.year}
            </Text>
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

  return (
    <Suspense fallback={<ShowTaxIncomeSkeleton />}>{renderStatus()}</Suspense>
  );
};

export default TaxIncomeCard;
