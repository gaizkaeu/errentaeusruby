import { useState, Fragment } from 'react'
import { Button, Text } from '@nextui-org/react'
import { useAuth } from '../../storage/hooks'
import SignIn from './SignIn'
import SignUp from './SignUp'
import { useNavigate, useParams } from 'react-router-dom'

const AuthComponent = () => {
  const [logIn, setLogIn] = useState(false)
  const [auth, fetched] = useAuth();
  const nav = useNavigate();
  const { action } = useParams();

  const loginSuccess = () => {
    nav(-1);
  }

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
          {logIn ? <SignIn loginSuccess={loginSuccess} /> : <SignUp loginSuccess={loginSuccess} />}
        </div>
      )}
    </Fragment>
  )
}
export default AuthComponent
