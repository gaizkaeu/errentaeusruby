import { useState, Fragment } from 'react'
import { Button, Text } from '@nextui-org/react'
import { useAuth } from '../../storage/hooks'
import SignIn from './SignIn'
import SignUp from './SignUp'

const AuthComponent = (props: {onAuth: () => void, method: boolean}) => {
  const [logIn, setLogIn] = useState(props.method)
  const [auth, fetched] = useAuth();

  return (
    <Fragment>
      {auth ? (
        <Text>ya estas logeado</Text>
      ) : (
        <div className="w-full grid-cols-1 justify-items-center">
          <div className="flex flex-wrap place-content-center items-center mt-4 gap-4 mb-4">
            <Text b size="md">{logIn ? "Iniciar sesión" : "Registro"}</Text>
            <Button size="sm" onPress={() => setLogIn((v) => !v)}>{!logIn ? "Iniciar sesión" : "Necesito registrarme"}</Button>
          </div>
          {logIn ? <SignIn loginSuccess={props.onAuth} /> : <SignUp loginSuccess={props.onAuth} />}
        </div>
      )}
    </Fragment>
  )
}
export default AuthComponent
