import React from 'react'
import { at } from 'lodash'
import { Field, useField, useFormikContext } from 'formik'
import { Card, Text } from '@nextui-org/react'

export default function YesNoField({...props }) {
  const { conditionalRender, showOn, children} = props
  const [field, meta, helpers] = useField(props.name)
  const {submitForm} = useFormikContext();
  
  function _renderHelperText() {
    const [touched, error] = at(meta, 'touched', 'error')
    if (touched && error) {
      return error
    }
  }

  const selectOption = async (v: number) => {
    helpers.setValue(v)
    if (!children || v != showOn) {
      await new Promise(f => setTimeout(f, 600));
      submitForm();
    }
  }

  return (
    <div role="group">
      <label>
        <Card
          isPressable
          isHoverable
          borderWeight= "extrabold"
          onPress={() => selectOption(1)}
          variant={field.value === 1 ? 'shadow' : 'bordered'}
        >
          <Card.Body>
            <Text>Si.</Text>
          </Card.Body>
        </Card>
      </label>
      <br/>
      <label>
        <Card
          isPressable
          isHoverable
          borderWeight= "extrabold"
          onPress={() => selectOption(0)}
          variant={field.value === 0 ? 'shadow' : 'bordered'}
        >
          <Card.Body>
            <Text>No.</Text>
          </Card.Body>
        </Card>
      </label>
      <br/>
        <Text color='red'>{_renderHelperText()}</Text>
        { conditionalRender &&  (field.value === showOn && children)}
    </div>
  )
}
