import React from 'react'
import { Button,  Grid,  Text, Textarea } from '@nextui-org/react'
import { Form, Formik, FormikHelpers } from 'formik'
import { useAppDispatch, useAppSelector } from '../../storage/hooks'
import { useNavigate } from 'react-router-dom'
import EstimationCard from '../Estimation/EstimationCard'
import 'react-day-picker/dist/style.css';
import { createTaxIncome, TaxIncomeData } from '../../storage/taxIncomeSlice'
import toast from 'react-hot-toast'
import { resetEstimation } from '../../storage/estimationSlice'
import { useCreateTaxIncomeMutation } from '../../storage/taxIncomeApi'

const NewTaxIncome = () => {
  const estimation = useAppSelector((state) => state.estimations.estimation)
  const [addTaxIncome, result] = useCreateTaxIncomeMutation();
  const navigate = useNavigate()

  const submitForm = async (
    values: TaxIncomeData,
    formikHelpers: FormikHelpers<any>,
  ) => {
    const toastNotification = toast.loading('Procesando...')
   addTaxIncome(values).unwrap().then((data) => {
    toast.success('Listo', {
      id: toastNotification
    })
    navigate(`/mytaxincome/${data.id}`)
   }).catch((error) => {
      toast.error('Error', {
        id: toastNotification
      })     
    formikHelpers.setErrors(error.data)
    })

    /* if (createTaxIncome.fulfilled.match(action)) {
      toast.success('¡Listo!', {
        id: toastNotification,
      })
      navigate(`/mytaxincome/${action.payload.id}`)
      dispatch(resetEstimation());
    } else {
      if (action.payload) {
        formikHelpers.setErrors(action.payload.field_errors)
        toast.error('Error', {
          id: toastNotification,
        })
      } else {
        toast.error('Error inesperado', {
          id: toastNotification,
        })
      } */
    }

  return (
    <React.Fragment>
      <Text h3>Solo te llevará 2 minutos más.</Text>

      <div>
        <Formik initialValues={{ load_price_from_estimation: false, observations: '' }} onSubmit={submitForm}>
          <Form>
          <Grid.Container gap={3}>
            <Grid xs={12} md={6}>
            <EstimationCard estimation={estimation} deletable/>
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
            size={'lg'}
            auto
            type="submit"
          >
            Continuar
          </Button>
          </Form>

        </Formik>
      </div>
    </React.Fragment>
  )
}

export default NewTaxIncome
