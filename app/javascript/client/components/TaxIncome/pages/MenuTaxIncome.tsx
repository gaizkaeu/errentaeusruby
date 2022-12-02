import { Fragment } from "react";
import { Button, Text } from "@nextui-org/react";
import TaxIncomeResume from "../components/TaxIncomeResume";
import { useNavigate } from "react-router-dom";
import { ShowMyAssignedTaxIncomes } from "../LawyerComponents/AssignedTaxIncomes";
import { useAuth } from "../../../hooks/authHook";
import { NewspaperIcon } from "@heroicons/react/24/outline";

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
            aria-label="create new tax income"
            iconRight={<NewspaperIcon height="15px" />}
          >
            <span className="hidden md:inline">Nueva declaración</span>
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
