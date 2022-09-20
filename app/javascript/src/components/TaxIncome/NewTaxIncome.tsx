import React from 'react'
import { Spacer, Switch, Text, Textarea } from '@nextui-org/react'
import { Form, Formik } from 'formik'
import { useAppSelector } from '../../storage/hooks'
import { useNavigate } from 'react-router-dom'
import EstimationCard from './EstimationCard'

const NewTaxIncome = () => {
  const estimation = useAppSelector((state) => state.estimations.estimation)
  const navigate = useNavigate()
  const submitForm = () => { }

  return (
    <React.Fragment>
      <Text h3>Solo te llevará 2 minutos más.</Text>

      <div>
        <Formik initialValues={{ addEstimation: false }} onSubmit={submitForm}>
          <Form>
            <div className="flex items-center gap-3 ">
              <Switch
                checked={estimation ? true : false}
                disabled={!estimation}
              />
              <EstimationCard estimation={estimation} />
            </div>
            <Spacer />
            <Textarea
              placeholder="¿Algo importante que debamos saber?"
              minRows={4}
              label="Observaciones"
              fullWidth
            />
          </Form>
        </Formik>
      </div>
    </React.Fragment>
  )
}

export default NewTaxIncome
