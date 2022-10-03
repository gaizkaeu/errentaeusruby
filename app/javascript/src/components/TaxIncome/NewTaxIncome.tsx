import {Fragment} from 'react'
import { Button, Grid, Text, Textarea } from '@nextui-org/react'
import { Form, Formik, FormikHelpers } from 'formik'
import { useNavigate } from 'react-router-dom'
import toast from 'react-hot-toast'
import { useCreateTaxIncomeMutation } from '../../storage/api'
import { TaxIncomeData } from '../../storage/types'
import { useAppSelector } from '../../storage/hooks'
import EstimationCard from '../Estimation/EstimationCard'

const NewTaxIncome = () => {
  const navigate = useNavigate()
  const estimation = useAppSelector((state) => state.estimations.estimation)
  const [addTaxIncome] = useCreateTaxIncomeMutation();

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

  }

  return (
    <Fragment>
      <Text h3>Solo te llevará 2 minutos más.</Text>

      <div>
        <Formik initialValues={{ load_price_from_estimation: false, observations: '' }} onSubmit={submitForm}>
          <Form>
            <Grid.Container gap={3}>
              <Grid xs={12} md={6}>
                <EstimationCard estimation={estimation} deletable />
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
    </Fragment>
  )
}

export default NewTaxIncome
