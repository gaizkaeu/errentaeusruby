import { Text, Button, Radio, Spacer } from "@nextui-org/react";
import { Form, Formik, FormikHelpers, useField } from "formik";
import DatePickerField from "../FormFields/DatePickerField";
import InputField from "../FormFields/InputField";
import { at } from "lodash";
import "react-day-picker/dist/style.css";
import { useTranslation } from "react-i18next";
import validationSchema from "./Model/validationSchema";

interface Values {
  day: string;
  hour: string;
  method: "office" | "phone";
  phone: string;
  appointment_id?: string;
}

const AppointmentTypeSelector = (props: {
  contactMethodFieldName: string;
  phone_field: string;
}) => {
  const { t } = useTranslation();

  const [methodField, methodMeta, methodHelpers] = useField(
    props.contactMethodFieldName
  );

  function _renderHelperText() {
    const [touched, error] = at(methodMeta, "touched", "error");
    if (touched && error) {
      return error;
    }
  }

  return (
    <Radio.Group
      name={props.contactMethodFieldName}
      label={t("appointments.form.fields.method.label")}
      onChange={(v) => {
        methodHelpers.setValue(v);
      }}
    >
      <Radio
        name={props.contactMethodFieldName}
        value="phone"
        description={t("appointments.form.fields.method.types.phone.label")}
      >
        {t("appointments.form.fields.method.types.phone.text")}
      </Radio>
      {methodField.value === "phone" && (
        <InputField
          name={props.phone_field}
          bordered
          label={t("appointments.form.fields.method.types.phone.phoneNumber")}
        />
      )}
      <Radio
        name={props.contactMethodFieldName}
        value="office"
        description={t("appointments.form.fields.method.types.office.label")}
      >
        {t("appointments.form.fields.method.types.office.text")}
      </Radio>
      <Text color="error">{_renderHelperText()}</Text>
    </Radio.Group>
  );
};

const AppointmentForm = (props: {
  onSubmit: (values: Values, formikHelpers: FormikHelpers<any>) => void;
}) => {
  const { t } = useTranslation();

  return (
    <Formik
      initialValues={{
        day: "",
        hour: "12:30",
        method: "office" as const,
        phone: "",
      }}
      validationSchema={validationSchema}
      onSubmit={props.onSubmit}
    >
      <Form>
        <Text h3>{t("appointments.form.scheduleAppointment")}</Text>
        <div className="flex flex-wrap place-content-center gap-4">
          <DatePickerField name="day" />
          <div>
            <InputField
              name="hour"
              type="time"
              label={t("appointments.form.fields.time.label")}
              rounded
              bordered
              fullWidth
            ></InputField>
            <Spacer />
            <AppointmentTypeSelector
              contactMethodFieldName="method"
              phone_field="phone"
            />
          </div>
        </div>
        <div className="flex mt-8">
          <Button color="primary" type="submit" className="flex-1">
            {t("appointments.form.submit")}
          </Button>
        </div>
      </Form>
    </Formik>
  );
};

export default AppointmentForm;
