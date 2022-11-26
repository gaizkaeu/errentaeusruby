import { Fragment } from "react";
import { Loading, Text } from "@nextui-org/react";
import {
  useGetAppointmentsQuery,
  useGetTaxIncomesQuery,
} from "../../storage/api";
import TaxIncomeCardMin from "./components/TaxIncomeCardMin";
import { AppointmentCard } from "../Appointment/Appointment";

const TaxIncomeResume = () => {
  const taxIncomes = useGetTaxIncomesQuery();
  const appointments = useGetAppointmentsQuery();

  return (
    <Fragment>
      <div className="grid grid-cols-1 gap-4 lg:grid-cols-2">
        <div className="">
          <Text h3>Mis declaraciones</Text>
          <div className="grid grid-cols-1 gap-4">
            {taxIncomes.isLoading ||
            taxIncomes.isError ||
            !taxIncomes.currentData ? (
              <Loading type="points" />
            ) : (
              taxIncomes.currentData?.map((v, ind) => {
                return (
                  <TaxIncomeCardMin taxIncome={v} key={ind}></TaxIncomeCardMin>
                );
              })
            )}
          </div>
        </div>
        <div className="">
          <Text h3>Mis citas</Text>
          <div className="grid grid-cols-1 gap-4">
            {appointments.isLoading ||
            appointments.isError ||
            !appointments.currentData ? (
              <Loading type="points" />
            ) : (
              appointments.currentData?.map((v, ind) => {
                return (
                  <AppointmentCard appointment={v} key={ind}></AppointmentCard>
                );
              })
            )}
          </div>
        </div>
      </div>
    </Fragment>
  );
};

export default TaxIncomeResume;
