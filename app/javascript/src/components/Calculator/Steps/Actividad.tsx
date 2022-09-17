import React from 'react'
import YesNoField from '../../FormFields/YesNoField'
import { FieldData } from '../Model/calculatorFormModel'

export default function Actividad(props: {
  formField: {
    professionalCompanyActivity: FieldData
  }
}){
  const {formField: {professionalCompanyActivity}} = props;
  return (
    <React.Fragment>
      <YesNoField name={professionalCompanyActivity.name}></YesNoField>
    </React.Fragment>
  )
}
