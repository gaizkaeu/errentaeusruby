import { Fragment, useState } from "react";
import { Loading, Progress, Text } from "@nextui-org/react";
import { Button } from "../../utils/GlobalStyles";
import { Form, Formik, FormikHelpers } from "formik";
import calculatorFormModel from "./Model/calculatorFormModel";
import Start from "./Steps/Start";
import Viviendas from "./Steps/Viviendas";
import PrimeraVez from "./Steps/PrimeraVez";
import Alquileres from "./Steps/Alquileres";
import validationSchema from "./Model/validationSchema";
import Actividad from "./Steps/Actividad";
import Inmueble from "./Steps/Inmueble";
import Pareja from "./Steps/Pareja";
import { useAppDispatch, useAppSelector } from "../../storage/hooks";
import Finish from "./Steps/Finish";
import { calculateEstimation } from "../../storage/estimationSlice";
import {
  nextStep,
  prevStep,
  valuesChanged,
  firstStep,
} from "../../storage/calculatorSlice";
import { toast } from "react-hot-toast";
import { CalculatorValues, QuestionWithNumber } from "../../storage/types";
import { useTranslation } from "react-i18next";
import { BottomSheet } from "react-spring-bottom-sheet";
import "react-spring-bottom-sheet/dist/style.css";
import { InformationCircleIcon } from "@heroicons/react/24/outline";

const steps = [
  "Información importante",
  "¿Es la primera vez que haces la declaración con nosotros?",
  "¿Has cambiado de vivienda habitual?",
  "¿Tienes alquileres y/o hipotecas?",
  "¿Tienes actividad empresarial o profesional?",
  "¿Has comprado o vendido inmuebles?",
  "¿Quieres hacer la declaración en matrimonio o con tu pareja de hecho?",
];
const { formId, formField } = calculatorFormModel;

function _renderStepContent(step: number) {
  switch (step) {
    case 0:
      return <Start formField={formField}></Start>;
    case 1:
      return <PrimeraVez formField={formField}></PrimeraVez>;
    case 2:
      return <Viviendas formField={formField}></Viviendas>;
    case 3:
      return <Alquileres formField={formField}></Alquileres>;
    case 4:
      return <Actividad formField={formField}></Actividad>;
    case 5:
      return <Inmueble formField={formField}></Inmueble>;
    case 6:
      return <Pareja formField={formField}></Pareja>;
    default:
      return <Text>Error</Text>;
  }
}

const calculateFinalNumber = (resp: QuestionWithNumber) => {
  return resp.consta === "1" ? resp.numero : 0;
};

export default function Calculator() {
  const dispatch = useAppDispatch();
  const valuesPersist = useAppSelector((state) => {
    return state.calculator.formValues;
  });
  const { t } = useTranslation();

  const stepPersist = useAppSelector((state) => {
    return state.calculator.step;
  });

  const isLastStep = stepPersist === steps.length - 1;

  async function _submitForm(
    values: CalculatorValues,
    formikHelpers: FormikHelpers<any>
  ) {
    const action = await dispatch(
      calculateEstimation({
        first_name: values.first_name,
        home_changes: calculateFinalNumber(values.homeChanges),
        first_time: parseInt(values.firstTime),
      })
    );

    if (calculateEstimation.fulfilled.match(action)) {
      dispatch(nextStep());
    } else {
      if (action.payload) {
        formikHelpers.setErrors(action.payload);
        toast.error("Error en el formulario");
        dispatch(firstStep());
      } else {
        toast.error("Error inesperado");
      }
    }

    formikHelpers.setSubmitting(false);
  }

  function _handleSubmit(
    values: CalculatorValues,
    formikHelpers: FormikHelpers<any>
  ) {
    if (isLastStep) {
      _submitForm(values, formikHelpers);
    } else {
      formikHelpers.setTouched({});
      dispatch(valuesChanged(values));
      dispatch(nextStep());
      formikHelpers.setSubmitting(false);
    }
  }

  function _handleBack() {
    dispatch(prevStep());
  }

  return (
    <Fragment>
      {stepPersist === steps.length ? (
        <Finish />
      ) : (
        <Formik
          initialValues={valuesPersist}
          validationSchema={validationSchema[stepPersist]}
          onSubmit={_handleSubmit}
        >
          {({ isSubmitting }) => (
            <Form id={formId} className="max-w-5xl ml-3 mr-3">
              <Progress
                color="primary"
                size="md"
                indeterminated={isSubmitting}
                value={(stepPersist / steps.length) * 100}
              />
              {stepPersist > 0 && (
                <div className="flex gap-x-4 items-center">
                  <Text h3 className="flex-1">
                    {steps[stepPersist]}
                  </Text>
                  <BottomSheetQuestions />
                </div>
              )}
              {_renderStepContent(stepPersist)}

              <div className="flex gap-4 mt-10">
                {stepPersist !== 0 && (
                  <Button
                    rounded
                    bordered
                    flat
                    color="warning"
                    onPress={_handleBack}
                    size={"md"}
                    auto
                  >
                    Atrás
                  </Button>
                )}
                <Button
                  rounded
                  bordered
                  flat
                  disabled={isSubmitting}
                  type="submit"
                  color="warning"
                  size={"md"}
                  auto
                >
                  {isLastStep
                    ? t("calculator.actions.finish")
                    : t("calculator.actions.finish")}
                  {isSubmitting && (
                    <Loading type="points" color="currentColor" size="sm" />
                  )}
                </Button>
              </div>
            </Form>
          )}
        </Formik>
      )}
    </Fragment>
  );
}

export const BottomSheetQuestions = () => {
  const [open, setOpen] = useState(false);

  function onDismiss() {
    setOpen(false);
  }
  return (
    <>
      <button
        onClick={(e) => {
          e.preventDefault();
          setOpen(true);
        }}
        className="focus:outline-none  font-medium rounded-lg text-sm p-2.5 text-center inline-flex items-center mr-2"
      >
        <InformationCircleIcon height={25} />
        <span className="sr-only">Ayuda</span>
      </button>
      <BottomSheet
        open={open}
        onDismiss={onDismiss}
        defaultSnap={({ maxHeight }) => maxHeight * 0.2}
        snapPoints={({ maxHeight }) => [maxHeight * 0.2, maxHeight * 0.7]}
        expandOnContentDrag={true}
      >
        <div className="p-2">
          <p className="text-black text-2xl font-extrabold">Ayuda.</p>
        </div>
      </BottomSheet>
    </>
  );
};
