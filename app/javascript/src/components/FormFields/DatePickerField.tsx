import React from 'react';
import {Text} from '@nextui-org/react';
import { at } from 'lodash';
import { useField } from 'formik';
import { DayOfWeek, DayPicker } from "react-day-picker"
import es from 'date-fns/locale/es';

export default function DatePickerField({...props}) {
  const { errorText, ...rest } = props;
  const [field, meta, helpers] = useField(props.name);
  const dayOfWeekMatcher: DayOfWeek = {
      dayOfWeek: [0, 6]
  };

  function _renderHelperText() {
    const [touched, error] = at(meta, 'touched', 'error');
    if (touched && error) {
      return <Text>{error}</Text>;
    }
  }

  function _renderColor() {
    if (meta.touched) {
      if (meta.error) {
        return "error"
      }
      return "success"
    } 
    return "default"
  }

  return (
    <DayPicker mode="single"
      selected={field.value}
      locale={es}
      disabled={dayOfWeekMatcher}
      footer={<Text color="error">{_renderHelperText()}</Text>}
      onSelect={(day: any) => {helpers.setValue(day)}}
    />
  );
}
