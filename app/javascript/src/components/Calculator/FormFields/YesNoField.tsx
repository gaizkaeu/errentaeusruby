import React from 'react'
import { at } from 'lodash'
import { Field, useField } from 'formik'
import { Card, Text } from '@nextui-org/react'

export default function YesNoField({...props }) {
  const { conditionalRender, showOn, children} = props
  const [field, meta] = useField(props.name)

  function _renderHelperText() {
    const [touched, error] = at(meta, 'touched', 'error')
    if (touched && error) {
      return error
    }
  }

  return (
    <div role="group">
      <label>
        <Field type="radio" name={field.name} value={1} className="hidden"/>
        <Card
          isPressable
          isHoverable
          borderWeight= "extrabold"
          variant={field.value === "1" ? 'shadow' : 'bordered'}
        >
          <Card.Body>
            <Text>Si.</Text>
          </Card.Body>
        </Card>
      </label>
      <br/>
      <label>
        <Field type="radio" name={field.name} value={0} className="hidden"/>
        <Card
          isPressable
          isHoverable
          borderWeight= "extrabold"
          variant={field.value === "0" ? 'shadow' : 'bordered'}
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
