import { Text, Loading, Card } from "@nextui-org/react";
import {
  useGetAppointmentByIdQuery,
  useGetAppointmentsQuery,
} from "../../storage/api";
import { DayPicker } from "react-day-picker";
import { formatRelative } from "date-fns";
import { es } from "date-fns/locale";
import es_day from "date-fns/locale/es";
import { Appointment } from "../../storage/types";
import { Link, useLocation } from "react-router-dom";
import { useTranslation } from "react-i18next";

export const AppointmentList = () => {
  const appointments = useGetAppointmentsQuery();
  return (
    <div className="grid grid-cols-1 gap-4">
      {appointments.isLoading ||
      appointments.isError ||
      !appointments.currentData ? (
        <Loading type="points" />
      ) : (
        appointments.currentData?.map((v, ind) => {
          return <AppointmentCard appointment={v} key={ind}></AppointmentCard>;
        })
      )}
    </div>
  );
};

export const AppointmentWrapper = (props: { appointmentId: string }) => {
  const { currentData, isError, isLoading } = useGetAppointmentByIdQuery(
    props.appointmentId
  );

  return isLoading || !currentData || isError ? (
    <Loading type="points" />
  ) : (
    <Appointment appointment={currentData} />
  );
};

const Appointment = (props: { appointment: Appointment }) => {
  const location = useLocation();
  const { t } = useTranslation();

  return (
    <div>
      <div className="flex w-full p-3">
        <div className="flex-1">
          <Text b>
            {t("appointments.myAppointment")} -{" "}
            {formatRelative(new Date(props.appointment.time), new Date(), {
              locale: es,
            })}
          </Text>{" "}
          <Link
            to={`/appointment/${props.appointment.id}/edit`}
            state={{ background: location }}
          >
            {t("appointments.actions.edit")}
          </Link>
        </div>
      </div>
      <div className="flex flex-wrap">
        <DayPicker
          locale={es_day}
          showOutsideDays
          selected={new Date(props.appointment.time)}
        ></DayPicker>
        <div>
          <Text>
            {props.appointment.method == "phone"
              ? t("appointments.appointmentMethod.phone")
              : t("appointments.appointmentMethod.office")}{" "}
          </Text>
          {props.appointment.method == "office" && (
            <a href="https://g.page/eliza-asesores?share">
              {t("appointments.officeAppointment.directions")}
            </a>
          )}
        </div>
      </div>
    </div>
  );
};

export const AppointmentCard = (props: { appointment: Appointment }) => {
  const { t } = useTranslation();

  return (
    <Card role="contentinfo" variant="flat">
      <Card.Header>
        <Text b>
          {formatRelative(new Date(props.appointment.time), new Date(), {
            locale: es,
          }).toLocaleUpperCase()}
        </Text>
      </Card.Header>
      <Card.Divider />
      <Card.Body>
        <Text>
          {props.appointment.method == "phone"
            ? t("appointments.appointmentMethod.phone")
            : t("appointments.appointmentMethod.office")}{" "}
        </Text>
        {props.appointment.method == "office" && (
          <a href={t("appointments.officeAppointment.directionLink") ?? ""}>
            {t("appointments.officeAppointment.directions")}
          </a>
        )}
      </Card.Body>
    </Card>
  );
};

export default Appointment;
