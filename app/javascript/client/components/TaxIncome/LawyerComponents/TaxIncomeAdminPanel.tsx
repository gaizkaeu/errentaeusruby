import { Text } from "@nextui-org/react";
import { Field, Form, Formik } from "formik";
import { t } from "i18next";
import {
  useGetUserByIdQuery,
  useUpdateTaxIncomeMutation,
} from "../../../storage/api";
import {
  TaxIncome,
  TaxIncomeStatuses,
} from "../../../storage/models/TaxIncome";
import { Button } from "../../../utils/GlobalStyles";
import InputField from "../../FormFields/InputField";
export const TaxIncomeAdminPanel = (props: { taxIncome: TaxIncome }) => {
  const { data } = useGetUserByIdQuery(props.taxIncome.user);
  const [updateTaxIncome] = useUpdateTaxIncomeMutation();

  const onSubmit = (values: TaxIncome) => {
    console.log(values);
    updateTaxIncome(values);
  };

  return (
    <div>
      <Text h3>Usuario {data?.first_name}</Text>
      <Formik initialValues={props.taxIncome} onSubmit={onSubmit}>
        <Form>
          <Field as="select" name="state">
            {TaxIncomeStatuses.map((val, id) => {
              return (
                <option key={id} value={val}>
                  {t(`taxincome.statuses.${val}`)}
                </option>
              );
            })}
          </Field>
          <br />
          <InputField label="precio" name="price"></InputField>
          <br />
          <InputField label="año" name="year"></InputField>
          <br />
          <Button type="submit">guardar</Button>
        </Form>
      </Formik>
    </div>
  );
};
