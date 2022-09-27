import React from 'react'
import { Formik, Form, FormikHelpers } from 'formik'
import * as Yup from 'yup'
import InputField from '../FormFields/InputField'
import PasswordField from '../FormFields/PasswordField'
import { Button, Spacer } from '@nextui-org/react'
import { signIn } from '../../storage/authSlice'
import { useAppDispatch } from '../../storage/hooks'
import toast from 'react-hot-toast'
import { SessionCreationData } from '../../storage/types'

const SignIn = (props: {loginSuccess: () => void}) => {
  
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
      props.loginSuccess();
    } else {
      if (action.payload) {
        formikHelpers.setFieldError('password', 'Error')
        formikHelpers.setFieldError('email', 'Error')
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
            Iniciar Sesión
          </Button>
        </Form>
      )}
    </Formik>
  )
}

export default SignIn
