import React from 'react'
import { Formik, Field, Form, ErrorMessage, FormikHelpers } from 'formik'
import * as Yup from 'yup'
import InputField from '../FormFields/InputField'
import PasswordField from '../FormFields/PasswordField'
import { Button, Spacer } from '@nextui-org/react'
import { SessionCreationData, signIn, signUp, UserRegistrationData } from '../../storage/authSlice'
import { useAppDispatch } from '../../storage/hooks'
import toast from 'react-hot-toast'

const SignIn = () => {
  
  const dispatch = useAppDispatch()

  const submitForm = async (values: SessionCreationData, formikHelpers: FormikHelpers<any>) => {
    const toastNotification = toast.loading('Procesando...')
    const action = await dispatch(
      signIn(values),
    )

    if (signIn.fulfilled.match(action)) {
      toast.success('Has iniciado sesión', {
        id: toastNotification,
      })
    } else {
      if (action.payload) {
        formikHelpers.setErrors(action.payload.errors)
        toast.error('Error ' + action.payload.error, {
          id: toastNotification,
        })
      } else {
        toast.error('Error inesperado', {
          id: toastNotification,
        })
      }
    }
  }

  return (
    <Formik
      initialValues={{  password: '', email: '' }}
      validationSchema={Yup.object({
        password: Yup.string().required('Password is required').min(6, 'Too short!'),
        email: Yup.string().email('Invalid email address').required('Required'),
      })}
      onSubmit={submitForm}
    >
      {({ isSubmitting }) => (
        <Form className="ml-3 mr-3">
          <InputField name="email" label="Email" fullWidth/>
          <Spacer y={1.5} />
          <PasswordField name="password" label="Contraseña" fullWidth></PasswordField>
          <Spacer y={2.5} />
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
            Registrarme
          </Button>
        </Form>
      )}
    </Formik>
  )
}

export default SignIn
