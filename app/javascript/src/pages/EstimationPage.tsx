import { Button, Text } from '@nextui-org/react'
import React from 'react'
import SingleEstimation from '../components/Estimation/Estimation'
import { useAppSelector } from '../storage/hooks'

function EstimationPage() {

  const estimations = useAppSelector((state) =>
    state.estimations,
  )

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
                textGradient: '45deg, $blue600 -20%, $pink600 50%',
              }}
            >
              Estimación
            </Text>
          </div>
            {estimations.price !== -1.0 ? (
              <div>
              <Text h4>Gracias por llegar hasta aquí. Esta información es solo visible para ti.</Text>
                <SingleEstimation estimation={estimations} req={estimations.estimation_props!}/>
              </div>
            ) : (
              <Text>No hay na</Text>
            )}
        </div>
      </section>
    </header>
  )
}

export default EstimationPage
