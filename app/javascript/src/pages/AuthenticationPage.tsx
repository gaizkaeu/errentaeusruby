import { Button, Text } from '@nextui-org/react'
import React from 'react'
import { useNavigate } from 'react-router-dom'
import SignUp from '../components/Authentication/SignUp'
import SingleEstimation from '../components/Estimation/Estimation'
import { ArrowIcon } from '../components/Icons/ArrowIcon'
import { firstStep } from '../storage/calculatorSlice'
import { useAppDispatch, useAppSelector } from '../storage/hooks'

function AuthenticationPage() {
  const estimations = useAppSelector((state) => state.estimations)
  const dispatch = useAppDispatch()
  const nav = useNavigate()

  return (
    <React.Fragment>
      <header>
        <section className="py-5 ">
          <div className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div>
              <Text className="text-base font-semibold tracking-wider">
                UN SERVICIO DE ELIZA ASESORES
              </Text>
              <Text
                className="text-5xl font-bold text-black sm:text-7xl  xl:text-8xl"
                css={{
                  textGradient: '45deg, $blue600 -20%, $pink600 50%',
                }}
              >
                INICIO DE SESIÓN
              </Text>
              <Text h4>Utilizamos las cuentas para proteger tus datos.</Text>
            </div>
          </div>
        </section>
      </header>
      <main>
        <SignUp/>
      </main>
    </React.Fragment>
  )
}

export default AuthenticationPage
