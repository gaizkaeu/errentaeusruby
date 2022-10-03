import {Fragment} from 'react'
import YesNoField from '../../FormFields/YesNoField'
import InputField from '../../FormFields/InputField'
import { FieldData } from '../Model/calculatorFormModel'

export default function Viviendas(props: {
    formField: {
      homeChangesQ: FieldData
      homeChangesNum: FieldData
    }
  }){
    const {formField: {homeChangesNum, homeChangesQ}} = props;

  return (
    <Fragment>
      <YesNoField showOn={1} name={homeChangesQ.name} conditionalRender>
        <InputField name={homeChangesNum.name} label={homeChangesNum.label} rounded bordered fullWidth></InputField>
      </YesNoField>
    </Fragment>
  )
}
