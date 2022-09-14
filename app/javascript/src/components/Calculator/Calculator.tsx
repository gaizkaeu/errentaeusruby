import { Button, Loading, Progress, Text } from '@nextui-org/react'
import { Form, Formik, FormikHelpers } from 'formik'
import calculatorFormModel from './Model/calculatorFormModel'
import React, { useState } from 'react'
import Start from './Steps/Start'
import Viviendas from './Steps/Viviendas'
import PrimeraVez from './Steps/PrimeraVez'
import Alquileres from './Steps/Alquileres'
import validationSchema from './Model/validationSchema'
import Actividad from './Steps/Actividad'
import Inmueble from './Steps/Inmueble'
import Pareja from './Steps/Pareja'
import { useAppDispatch } from '../../storage/hooks'
import Finish from './Steps/Finish'
import { calculateEstimation } from '../../storage/estimationSlice'
import { useNavigate } from 'react-router-dom'

const steps = [
  'Información importante',
  '¿Es la primera vez que haces la declaración con nosotros?',
  '¿Has cambiado de vivienda habitual?',
  '¿Tienes alquileres y/o hipotecas?',
  '¿Tienes actividad empresarial o profesional?',
  '¿Has comprado o vendido inmuebles?',
  '¿Quieres hacer la declaración en matrimonio o con tu pareja de hecho?',
]
const { formId, formField } = calculatorFormModel

interface Values {
  firstName: string
  firstTime: string
  homeChanges: QuestionWithNumber
  rentalsMortgages: QuestionWithNumber
  realStateTrade: QuestionWithNumber
  withCouple: string,
/*   incomeRent: QuestionWithNumber,
  sharesTrade: QuestionWithNumber, */
  professionalCompanyActivity: string
}

interface QuestionWithNumber {
  consta: string
  numero: number
}

function _renderStepContent(step: number) {
  switch (step) {
    case 0:
      return <Start formField={formField}></Start>
    case 1:
      return <PrimeraVez formField={formField}></PrimeraVez>
    case 2:
      return <Viviendas formField={formField}></Viviendas>
    case 3:
      return <Alquileres formField={formField}></Alquileres>
    case 4:
      return <Actividad formField={formField}></Actividad>
    case 5:
      return <Inmueble formField={formField}></Inmueble>
    case 6:
      return <Pareja formField={formField}></Pareja>
    default:
      return <Text>Error</Text>
  }
}

const calculateFinalNumber = (resp: QuestionWithNumber) => {
  return (resp.consta === "1" ? resp.numero : 0) 
}

export default function Calculator() {
  const [activeStep, setActiveStep] = useState(0)
  const isLastStep = activeStep === steps.length - 1
  const dispatch = useAppDispatch()
  const navigate = useNavigate();

  async function _submitForm(
    values: Values,
    formikHelpers: FormikHelpers<any>,
  ) {

    await dispatch(calculateEstimation({
      first_name: values.firstName,
      home_changes: calculateFinalNumber(values.homeChanges),
      first_time: parseInt(values.firstTime)
    }))

    formikHelpers.setSubmitting(false)

    setActiveStep(activeStep + 1)
  }

  function _handleSubmit(values: Values, formikHelpers: FormikHelpers<any>) {
    if (isLastStep) {
      _submitForm(values, formikHelpers)
    } else {
      setActiveStep(activeStep + 1)
      formikHelpers.setTouched({})
      formikHelpers.setSubmitting(false)
    }
  }

  function _handleBack() {
    setActiveStep(activeStep - 1)
  }

  return (
    <React.Fragment>
      <React.Fragment>
        {activeStep === steps.length ? (
          <Finish />
        ) : (
          <Formik
            initialValues={{
              firstName: '',
              homeChanges: {
                consta: '',
                numero: 1,
              },
              rentalsMortgages: {
                consta: '',
                numero: 1,
              },
              realStateTrade: {
                consta: '',
                numero: 1,
              },
              firstTime: '',
              withCouple: '',
              professionalCompanyActivity: '',
            }}
            validationSchema={validationSchema[activeStep]}
            onSubmit={_handleSubmit}
          >
            {({ isSubmitting }) => (
              <Form id={formId} className="max-w-5xl ml-3 mr-3">
                <Progress
                  color="primary"
                  size="xs"
                  value={(activeStep / steps.length) * 100}
                />
                <Text h3>{steps[activeStep]}</Text>
                {_renderStepContent(activeStep)}

                <div className="flex gap-4 mt-10">
                  {activeStep !== 0 && (
                    <Button
                      rounded
                      bordered
                      flat
                      color="warning"
                      onPress={_handleBack}
                      size={'md'}
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
                    size={'md'}
                    auto
                  >
                    {isLastStep ? 'Finalizar' : 'Siguiente'}
                    {isSubmitting && (
                      <Loading type="points" color="currentColor" size="sm" />
                    )}
                  </Button>
                </div>
              </Form>
            )}
          </Formik>
        )}
      </React.Fragment>
    </React.Fragment>
  )
}

export type { QuestionWithNumber }
