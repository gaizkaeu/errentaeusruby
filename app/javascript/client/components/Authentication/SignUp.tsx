/* eslint-disable @typescript-eslint/no-unused-vars */
import { Formik, Form, FormikHelpers } from "formik";
import * as Yup from "yup";
import InputField from "../FormFields/InputField";
import PasswordField from "../FormFields/PasswordField";
import { Button, Grid, Spacer } from "@nextui-org/react";
import { useAppSelector } from "../../storage/hooks";
import toast from "react-hot-toast";
import { UserRegistrationData } from "../../storage/types";
import { useCreateNewAccountMutation } from "../../storage/api";

const SignUp = () => {
  const firstName = useAppSelector((state) => {
    return state.estimations.estimation?.first_name;
  });
  const [createAccount] = useCreateNewAccountMutation();

  const submitForm = async (
    values: UserRegistrationData,
    formikHelpers: FormikHelpers<any>
  ) => {
    const toastNotification = toast.loading("Procesando...");
    createAccount(values)
      .unwrap()
      .then(() => toast.success("¡Bienvenido!", { id: toastNotification }))
      .catch(() => toast.error("Error", { id: toastNotification }));
  };

  return (
    <Formik
      initialValues={{
        first_name: firstName ?? "",
        last_name: "",
        password_confirmation: "",
        password: "",
        email: "",
      }}
      validationSchema={Yup.object({
        first_name: Yup.string().required("Necesario").min(4, "Too short!"),
        last_name: Yup.string().required("Necesario").min(4, "Too short!"),
        password: Yup.string()
          .required("Password is required")
          .min(6, "Too short!"),
        password_confirmation: Yup.string().oneOf(
          [Yup.ref("password"), null],
          "Passwords must match"
        ),
        email: Yup.string().email("Invalid email address").required("Required"),
      })}
      onSubmit={submitForm}
    >
      {({ isSubmitting }) => (
        <Form className="ml-3 mr-3">
          <Grid.Container gap={1}>
            <Grid xs={12} md={6}>
              <InputField
                name="first_name"
                label="Nombre"
                size="xl"
                fullWidth
                bordered
              />
            </Grid>
            <Grid xs={12} md={6}>
              <InputField
                name="last_name"
                label="Apellido"
                size="xl"
                fullWidth
                bordered
              />
            </Grid>
          </Grid.Container>
          <Spacer y={1.5} />
          <Grid.Container gap={1}>
            <Grid xs={12} md={12}>
              <InputField name="email" label="Email" fullWidth bordered />
            </Grid>
          </Grid.Container>
          <Spacer y={1.5} />
          <Grid.Container gap={1} alignItems="center">
            <Grid xs={12} md={6}>
              <PasswordField
                name="password"
                label="Contraseña"
                fullWidth
                bordered
              />
            </Grid>
            <Grid xs={12} md={6}>
              <PasswordField
                name="password_confirmation"
                label="Confirmar Contraseña"
                fullWidth
                bordered
              />
            </Grid>
          </Grid.Container>
          <Spacer y={2.5} />
          <Button
            rounded
            bordered
            flat
            disabled={isSubmitting}
            type="submit"
            color="primary"
            size={"md"}
            auto
          >
            Registrarme
          </Button>
        </Form>
      )}
    </Formik>
  );
};

export default SignUp;
