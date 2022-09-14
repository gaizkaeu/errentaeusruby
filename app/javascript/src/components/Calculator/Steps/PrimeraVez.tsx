import React from 'react'
import YesNoField from '../FormFields/YesNoField'
import { Text } from '@nextui-org/react'
import { FieldData } from '../Model/calculatorFormModel'

export default function PrimeraVez(props: {
  formField: {
    firstTime: FieldData
  }
}){
  const {formField: {firstTime}} = props;
  return (
    <React.Fragment>
      <YesNoField name={firstTime.name}></YesNoField>
      <Text>Si en otros años has hecho la declaración con nosotros eres elegible para un descuento del 10%</Text>
    </React.Fragment>
  )
}
