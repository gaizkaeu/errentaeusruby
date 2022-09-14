import { Text } from '@nextui-org/react'
import React from 'react'
import CalculatorComponent from '../components/Calculator/Calculator'

function CalculatorPage() {
  return (
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
                textGradient: '45deg, $yellow600 -20%, $red600 100%',
              }}
            >
              Calculadora
            </Text>
          </div>
          <div className="">
            <CalculatorComponent />
          </div>
        </div>
      </section>
    </header>
  )
}

export default CalculatorPage
