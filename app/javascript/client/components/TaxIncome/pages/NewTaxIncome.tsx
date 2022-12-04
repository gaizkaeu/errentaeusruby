import { Grid, Text, Textarea } from "@nextui-org/react";
import { Form, Formik, FormikHelpers } from "formik";
import { useNavigate, useSearchParams } from "react-router-dom";
import toast from "react-hot-toast";
import { useCreateTaxIncomeMutation } from "../../../storage/api";
import { EstimationFromJWTWrapper } from "../../Estimation/EstimationCard";
import { TaxIncomeData } from "../../../storage/models/TaxIncome";
import { Button } from "../../../utils/GlobalStyles";

const NewTaxIncome = () => {
  const navigate = useNavigate();
  const [searchParams, setSearchParams] = useSearchParams();
  const [addTaxIncome] = useCreateTaxIncomeMutation();

  const deleteEstimation = () => {
    searchParams.delete("j");
    setSearchParams(searchParams);
  };

  const submitForm = async (
    values: TaxIncomeData,
    formikHelpers: FormikHelpers<TaxIncomeData>
  ) => {
    const toastNotification = toast.loading("Procesando...");
    addTaxIncome(values)
      .unwrap()
      .then((data) => {
        toast.success("Listo", {
          id: toastNotification,
        });
        navigate(`/mytaxincome/${data.id}`);
      })
      .catch((error) => {
        toast.error("Error", {
          id: toastNotification,
        });
        formikHelpers.setErrors(error.data);
      });
  };

  return (
    <div className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
      <Text h2>Nueva declaración.</Text>
      <Text h4>Solo te llevará unos segundos más.</Text>

      <div>
        <Formik
          initialValues={{
            observations: "",
            estimation: { token: searchParams.get("j") ?? "" },
          }}
          onSubmit={submitForm}
        >
          <Form>
            <Grid.Container gap={3}>
              <Grid xs={12} md={6}>
                <EstimationFromJWTWrapper
                  token={searchParams.get("j") ?? undefined}
                  deletable
                  delete={deleteEstimation}
                />
              </Grid>
              <Grid xs={12} md={6}>
                <Textarea
                  placeholder="¿Algo importante que debamos saber?"
                  minRows={4}
                  label="Observaciones"
                  fullWidth
                />
              </Grid>
            </Grid.Container>
            <Button
              rounded
              className="px-6 py-4 mt-8"
              color="primary"
              size={"lg"}
              auto
              type="submit"
            >
              Continuar
            </Button>
          </Form>
        </Formik>
      </div>
    </div>
  );
};

export default NewTaxIncome;
