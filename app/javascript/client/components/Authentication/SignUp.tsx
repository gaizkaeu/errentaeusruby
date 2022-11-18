import { Formik, Form, FormikHelpers } from "formik";
import * as Yup from "yup";
import InputField from "../FormFields/InputField";
import PasswordField from "../FormFields/PasswordField";
import { Button, Grid, Spacer } from "@nextui-org/react";
import { signUp } from "../../storage/authSliceold";
import { useAppDispatch, useAppSelector } from "../../storage/hooks";
import toast from "react-hot-toast";
import { UserRegistrationData } from "../../storage/types";

const SignUp = (props: { loginSuccess: () => void }) => {
  const dispatch = useAppDispatch();
  const firstName = useAppSelector((state) => {
    return state.estimations.estimation?.first_name;
  });

  const submitForm = async (
    values: UserRegistrationData,
    formikHelpers: FormikHelpers<any>
  ) => {
    const toastNotification = toast.loading("Procesando...");
    const action = await dispatch(signUp(values));

    if (signUp.fulfilled.match(action)) {
      toast.success("Has iniciado sesión", {
        id: toastNotification,
      });
      props.loginSuccess();
    } else {
      if (action.payload) {
        formikHelpers.setErrors(action.payload.errors);
        toast.error("Error", {
          id: toastNotification,
        });
      } else {
        toast.error("Error inesperado", {
          id: toastNotification,
        });
      }
    }
  };

  return (
    <Formik
      initialValues={{
        name: firstName ?? "",
        surname: "",
        password_confirmation: "",
        password: "",
        email: "",
      }}
      validationSchema={Yup.object({
        name: Yup.string().required("Necesario").min(4, "Too short!"),
        surname: Yup.string().required("Necesario").min(4, "Too short!"),
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
                name="name"
                label="Nombre"
                size="xl"
                fullWidth
                bordered
              />
            </Grid>
            <Grid xs={12} md={6}>
              <InputField
                name="surname"
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
