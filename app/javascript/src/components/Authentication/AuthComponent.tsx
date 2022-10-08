import { useState, Fragment } from 'react'
import { Button, Text } from '@nextui-org/react'
import SignIn from './SignIn'
import SignUp from './SignUp'
import { Link, Location } from 'react-router-dom'
import CheckAnimated from '../Icons/CheckAnimated'
import { useAuth } from '../../hooks/authHook'

export const RequiresAuthentication = (props: {nextPage: string, location: Location}) => {
  return (
    <div>
      <Text>Es necesario tener una cuenta para continuar</Text>
      <Text>
        <Link to="/auth/sign_in" state={{ background: props.location, nextPage: props.nextPage}}>Iniciar sesión</Link>
        {' '} o {' '} 
        <Link to="/auth/sign_up" state={{ background: props.location, nextPage: props.nextPage }}>Registrarme</Link>
      </Text>
    </div>
  )
}

const AuthComponent = (props: {onAuth: () => void, method: boolean}) => {
  const [logIn, setLogIn] = useState(props.method)
  const {status} = useAuth();

  return (
    <Fragment>
      {status.loggedIn ? (
        <CheckAnimated/>
      ) : (
        <div className="w-full grid-cols-1 items-center align-center">
          <Text b size="md">{logIn ? "Iniciar sesión" : "Registro"}</Text>
          {logIn ? <SignIn loginSuccess={props.onAuth} /> : <SignUp loginSuccess={props.onAuth} />}
        </div>
      )}
    </Fragment>
  )
}
export default AuthComponent
