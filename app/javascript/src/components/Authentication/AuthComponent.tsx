import React, { useState } from 'react'
import { Button, Text } from '@nextui-org/react'
import { useAppDispatch, useAppSelector } from '../../storage/hooks'
import SignIn from './SignIn'
import SignUp from './SignUp'

const AuthComponent = () => {
  const [logIn, setLogIn] = useState(false)
  const logged_in = useAppSelector((state) => state.authentication.logged_in)

  return (
    <React.Fragment>
      {logged_in ? (
        <Text>ya estas logeado</Text>
      ) : (
        <div className="w-full">
          <div className="flex flex-wrap place-content-center items-center mt-4 gap-4">
            <Text b size="md">{logIn ? "Iniciar sesión" : "Registro"}</Text>
            <Button size="sm" onPress={() => setLogIn((v) => !v)}>{!logIn ? "Iniciar sesión" : "Necesito registrarme"}</Button>
          </div>
          {logIn ? <SignIn /> : <SignUp />}
        </div>
      )}
    </React.Fragment>
  )
}
export default AuthComponent
