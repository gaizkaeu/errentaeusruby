import {Fragment} from 'react'
import { Button, Text } from '@nextui-org/react'
import { Outlet } from 'react-router-dom'

function TaxIncomePage() {

  return (
    <Fragment>
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
                Tu declaración
              </Text>
            </div>
          </div>
        </section>
      </header>
      <main className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
        <Outlet/>
      </main>
    </Fragment>
  )
}

export default TaxIncomePage
