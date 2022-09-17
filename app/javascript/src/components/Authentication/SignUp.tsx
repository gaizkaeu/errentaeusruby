import React from 'react'
import { Formik, Field, Form, ErrorMessage } from 'formik'
import * as Yup from 'yup'
import InputField from '../FormFields/InputField'
import PasswordField from '../FormFields/PasswordField'
import { Button } from '@nextui-org/react'

const SignUp = () => {
  return (
    <Formik
      initialValues={{ firstName: '', lastName: '', email: '' }}
      validationSchema={Yup.object({
        firstName: Yup.string()
          .max(15, 'Must be 15 characters or less')
          .required('Required'),
        lastName: Yup.string()
          .max(20, 'Must be 20 characters or less')
          .required('Required'),
        email: Yup.string().email('Invalid email address').required('Required'),
      })}
      onSubmit={(values, { setSubmitting }) => {
        setTimeout(() => {
          alert(JSON.stringify(values, null, 2))
          setSubmitting(false)
        }, 400)
      }}
    >
      {({ isSubmitting }) => (
        <Form className="max-w-5xl ml-3 mr-3">
          <InputField name="firstName" label="Frist Name"></InputField>
          <br/>
          <InputField name="lastName" label="Last Name"></InputField>
          <br/>
          <InputField name="email" label="Email"></InputField>
          <br/>
          <PasswordField name="password" label="Contraseña"></PasswordField>
          <br/>
          <Button
            rounded
            bordered
            flat
            disabled={isSubmitting}
            type="submit"
            color="warning"
            size={'md'}
            auto
          >
            {' '}
            Registrarme{' '}
          </Button>
        </Form>
      )}
    </Formik>
  )
}

export default SignUp
