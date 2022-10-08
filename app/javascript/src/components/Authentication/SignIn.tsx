import { Formik, Form, FormikHelpers } from 'formik'
import * as Yup from 'yup'
import InputField from '../FormFields/InputField'
import PasswordField from '../FormFields/PasswordField'
import { Button, Spacer } from '@nextui-org/react'
import { signIn } from '../../storage/authSlice'
import { useAppDispatch } from '../../storage/hooks'
import toast from 'react-hot-toast'
import { SessionCreationData } from '../../storage/types'
import { Link } from 'react-router-dom'
import { useAuth } from '../../hooks/authHook'

const SignIn = (props: {loginSuccess: () => void}) => {
  
  const dispatch = useAppDispatch()
  const {actions} = useAuth();


  return (
    <Formik
      initialValues={{  password: '', email: '' }}
      validationSchema={Yup.object({
        password: Yup.string().required('Password is required').min(6, 'Too short!'),
        email: Yup.string().email('Invalid email address').required('Required'),
      })}
      onSubmit={(v, e) => actions.formLogIn(v, e, props.loginSuccess)}
    >
      {({ isSubmitting }) => (
        <Form className="ml-3 mr-3">
          <InputField name="email" label="Email" fullWidth bordered/>
          <Spacer y={1.5} />
          <PasswordField name="password" label="Contraseña" fullWidth bordered></PasswordField>
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
