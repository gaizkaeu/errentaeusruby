import { Fragment } from 'react'
import { Text } from '@nextui-org/react'
import YesNoField from '../../FormFields/YesNoField'
import { FieldData } from '../Model/calculatorFormModel'

export default function Pareja(props: {
  formField: {
    withCouple: FieldData
  }
}){
  const {formField: {withCouple}} = props;
  return (
    <Fragment>
      <YesNoField name={withCouple.name}></YesNoField>
      <Text>Al hacer la declaración en pareja eres elegible para un descuento del 25%.</Text>
    </Fragment>
  )
}
