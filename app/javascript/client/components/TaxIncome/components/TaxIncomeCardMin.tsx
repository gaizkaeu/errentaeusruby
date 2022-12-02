import { Button, Card, Text } from "@nextui-org/react";
import { RightArrowIcon } from "../../Icons/RightArrowIcon";
import { useNavigate } from "react-router-dom";
import {
  AssignedLawyerSimple,
  LawyerSkeleton,
} from "../../Lawyer/AssignedLawyer";
import { formatRelative } from "date-fns";
import es from "date-fns/locale/es";
import { TaxIncome } from "../../../storage/models/TaxIncome";

const TaxIncomeCardMin = (props: { taxIncome: TaxIncome }) => {
  const nav = useNavigate();

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
      isPressable
      onPress={() => nav(`/mytaxincome/${taxIncome.id}`)}
    >
      <Card.Header>{renderStatus()}</Card.Header>
      <Card.Divider />
      <Card.Body>
        <div className="flex flex-wrap items-center">
          <div className="flex-1">
            {taxIncome.lawyer ? (
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

export default TaxIncomeCardMin;
