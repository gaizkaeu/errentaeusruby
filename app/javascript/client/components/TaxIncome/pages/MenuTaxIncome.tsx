import { Text } from "@nextui-org/react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../../../hooks/authHook";
import { PlusCircleIcon } from "@heroicons/react/24/outline";
import { Button, MainDiv } from "../../../utils/GlobalStyles";
import { AppointmentList } from "../../Appointment/Appointment";
import { TaxIncomeCardMinList } from "../components/TaxIncomeCard";

const TaxIncomeResume = (props: { lawyer: boolean }) => {
  return (
    <div className="grid grid-cols-1 gap-4 lg:grid-cols-2 mx-auto max-w-7xl sm:px-6 lg:px-8 px-4">
      <div className="-translate-y-16">
        <TaxIncomeCardMinList searchBar={props.lawyer} />
      </div>
      <div className="-translate-y-9">
        <Text h3 b>
          Citas
        </Text>
        <AppointmentList />
      </div>
    </div>
  );
};

const MenuTaxIncome = () => {
  const nav = useNavigate();
  const { currentUser } = useAuth();
  return (
    <>
      <div className="flex px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
        <div className="flex-1">
          <Text h3>Hola, {currentUser?.first_name}. 👋</Text>
        </div>
        <div>
          <Button
            rounded
            color="success"
            auto
            onPress={() => nav("new")}
            aria-label="create new tax income"
            icon={<PlusCircleIcon height="25px" />}
          >
            <span className="hidden md:inline">Nueva declaración</span>
          </Button>
        </div>
      </div>
      <MainDiv className="mt-20">
        <TaxIncomeResume lawyer={currentUser?.account_type == "lawyer"} />
      </MainDiv>
    </>
  );
};

export default MenuTaxIncome;
