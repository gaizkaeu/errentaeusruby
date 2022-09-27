import React from 'react'
import ContinueEstimation from '../components/Estimation/ContinueEstimation'
import SingleEstimation from '../components/Estimation/SingleEstimation'
import { useAppSelector } from '../storage/hooks'
import { Text } from '@nextui-org/react'

function EstimationPage() {
  const estimations = useAppSelector((state) => state.estimations.estimation)

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
                Estimación
              </Text>
              <Text h4>
                Gracias por llegar hasta aquí. Esta información es solo visible
                para ti.
              </Text>
            </div>
          </div>
        </section>
      </header>
      <main className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
        {estimations ? (
          <div className="grid items-center grid-cols-1 lg:grid-cols-2 gap-10 p-3 self-center">
            <SingleEstimation
              estimation={estimations}
            />
            <ContinueEstimation/> 
          </div>
        ) : (
          <Text>No hay na</Text>
        )}
      </main>
    </React.Fragment>
  )
}

export default EstimationPage
