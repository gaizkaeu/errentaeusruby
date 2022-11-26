import { t } from "i18next";
import * as Yup from "yup";

const validationSchema = Yup.object({
  day: Yup.date().required(),
  hour: Yup.string()
    .min(4, t("appointments.form.fields.time.error") ?? "error")
    .required(),
  method: Yup.string(),
  phone: Yup.number().when("method", {
    is: "phone",
    then: Yup.number().min(9).required(),
  }),
});

export default validationSchema;
