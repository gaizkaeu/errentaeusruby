import React from 'react'
import YesNoField from '../FormFields/YesNoField'
import InputField from '../FormFields/InputField'
import { FieldData } from '../Model/calculatorFormModel'

export default function Inmueble(props: {
  formField: {
    realStateTradeQ: FieldData
    realStateTradeNum: FieldData
  }
}){
  const {formField: {realStateTradeNum, realStateTradeQ}} = props;
  return (
    <React.Fragment>
      <YesNoField showOn="1" name={realStateTradeQ.name} conditionalRender>
        <InputField name={realStateTradeNum.name} label={realStateTradeQ.label} rounded bordered fullWidth></InputField>
      </YesNoField>
    </React.Fragment>
  )
}
