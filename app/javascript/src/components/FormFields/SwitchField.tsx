import React from 'react';
import { at } from 'lodash';
import { useField } from 'formik';
import { Switch } from '@nextui-org/react'

export default function SwitchField({...props}) {
  const { errorText, ...rest } = props;
  const [field, meta] = useField(props.name);

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
    <Switch
      color={_renderColor()}
      size="xl"
      {...field}
      {...rest}
    />
  );
}
