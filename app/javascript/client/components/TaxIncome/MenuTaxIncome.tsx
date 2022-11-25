import { Fragment } from "react";
import { Button, Text } from "@nextui-org/react";
import TaxIncomeResume from "./TaxIncomeResume";
import { useNavigate } from "react-router-dom";
import { ArrowIcon } from "../Icons/ArrowIcon";
import { ShowMyAssignedTaxIncomes } from "./LawyerComponents/AssignedTaxIncomes";
import { useAuth } from "../../hooks/authHook";

const MenuTaxIncome = () => {
  const nav = useNavigate();
  const { currentUser } = useAuth();
  return (
    <Fragment>
      <div className="flex">
        <div className="flex-1">
          <Text h3>Hola, {currentUser?.first_name}</Text>
        </div>
        <div>
          <Button
            rounded
            color="success"
            auto
            onPress={() => nav("new")}
            iconRight={<ArrowIcon />}
          >
            Nueva declaración
          </Button>
        </div>
      </div>
      {currentUser?.account_type == "user" && (
        <section className="mt-2">
          <TaxIncomeResume />
        </section>
      )}
      {currentUser?.account_type == "lawyer" && (
        <section className="mt-2">
          <Text h4> Mis declaraciones asignadas</Text>
          <ShowMyAssignedTaxIncomes />
        </section>
      )}
    </Fragment>
  );
};

export default MenuTaxIncome;
